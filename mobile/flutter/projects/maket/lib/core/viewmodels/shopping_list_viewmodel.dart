import 'package:maket/constants/common.dart';
import 'package:maket/constants/items.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/services/internal/shopping_list_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/core/viewmodels/item_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';

class ShoppingListViewModel extends BaseViewModel {
  final ShoppingListService _service = locator<ShoppingListService>();

  HttpResponse _response = Response.build();

  HttpResponse _responseListItems = Response.build();

  Map<String, List<ItemModel>> _localListItems = {};

  HttpResponse get response => _response;

  HttpResponse get responseListItems => _responseListItems;

  int _selectedElementsCounter = Numbers.zero;

  bool _isAllElementSelected = false;

  double _spent = Numbers.asDouble(Numbers.zero);

  int get selectedElementsCounter => _selectedElementsCounter;

  bool get hasLists => listSize > Numbers.zero;

  bool get hasItems => itemsSize > Numbers.zero;

  int get listSize => response.data.length;

  int get itemsSize => responseListItems.data.length;

  bool get isAllSelected => _isAllElementSelected;

  String get getSpent => Numbers.stringAsFixed(number: _spent);

  Map<String, int> listItemsCount = {};

  List<ShoppingListModel> searchedItems = [];

  List<ShoppingListModel> get getSearchedItems => searchedItems;

  bool get hasSearchedResults => searchedItems.isNotEmpty;

  // Methods

  Future<HttpResponse> create({ShoppingListModel shoppingList}) async {
    busy;
    try {
      final Map<String, dynamic> _newlyCreatedList =
          await _service.create(shoppingList: shoppingList.toJson());

      await _addNewlyCreatedListToLocalLists(newList: _newlyCreatedList);

      idle;
      return Response.build(message: 'List Successfully Created.');
    } on ApiException catch (ex) {
      idle;

      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;

      return Response.build(status: false, message: 'Failed to create.');
    }
  }

  Future<void> getAllListBodies() async {
    busy;
    try {
      if (!hasLists) {
        List<dynamic> _shoppingListJson = await _service.getAllListBodies();

        List<ShoppingListModel> _shoppingLists =
            ShoppingListModel.shoppingListBodiesFromJson(
                jsonShoppingListBodies: _shoppingListJson);

        _response = Response.build(data: _shoppingLists);
      }
      idle;
    } on ApiException catch (ex) {
      _response =
          Response.build(status: false, code: ex.code, message: ex.message);

      idle;
    } catch (ex) {
      print(ex);
      _response =
          Response.build(status: false, message: 'Failed to get Lists.');

      idle;
    }
  }

  Future<void> getListItems({String listId}) async {
    busy;
    try {
      if (_localListItems.containsKey(listId)) {
        _setListItemsToResponse(items: _localListItems[listId]);
      } else {
        List<ItemModel> _items = ItemViewModel.orderItemsByCategories(
          items: await _service.getItemsById(listId: listId),
        );

        _setListItemsToResponse(items: _items);
        _saveListItemsToLocal(listId: listId);
      }
      _resetSpent();
      _calculateSpent();

      idle;
    } on ApiException catch (ex) {
      print(ex.message);
      _responseListItems =
          Response.build(status: false, code: ex.code, message: ex.message);
      idle;
    } catch (ex) {
      print(ex);
      _responseListItems =
          Response.build(status: false, message: 'Can\'t get the Lists');
      idle;
    }
  }

  Future<HttpResponse> setListItemPrice({ItemModel item, String listId}) async {
    try {
      await _service.setItemPrice(listId: listId, item: item);

      _responseListItems.data.forEach((ItemModel currentItem) {
        if (currentItem.id == item.id) {
          currentItem.price = item.price;
          currentItem.quantity = item.quantity;
          currentItem.bought = item.bought;
        }
      });

      _resetSpent();
      _calculateSpent();
      _increaseListSpent(listId: listId);

      final String _responseMessage = (item.bought)
          ? '${item.name} price set'
          : '${item.name} Price removed';

      idle;
      return Response.build(message: _responseMessage);
    } on ApiException catch (ex) {
      idle;
      print('api ex. ${ex.message}');
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;
      print('** $ex');
      return Response.build(status: false, message: 'Failed to set the Price');
    }
  }

  Future<void> selectShoppingList({ShoppingListModel list}) async {
    busy;
    _response.data.forEach((ShoppingListModel currentList) {
      if (currentList.id == list.id) {
        currentList.selected = !list.selected;
      }
      return currentList;
    });
    idle;
  }

  Future<void> unselectAllShoppingLists() async {
    busy;
    _response.data.forEach((ShoppingListModel currentList) {
      currentList.selected = false;
      return currentList;
    });
    _isAllElementSelected = false;
    idle;
  }

  Future<void> selectAllShoppingLists() async {
    busy;
    _response.data.forEach((ShoppingListModel currentList) {
      currentList.selected = !isAllSelected;
      return currentList;
    });
    idle;
  }

  Future<HttpResponse> deleteSelectedShoppingLists() async {
    busy;
    try {
      final List<String> _listIds = _getSelectedListsIds();

      final String _responseMessage =
          await _service.deleteMany(listIds: _listIds);

      await _removeSelectedListsFromCurrentLists(selectedListIds: _listIds);

      _responseListItems = Response.build();
      // _selectedMissingItems = [];
      searchedItems = [];

      idle;
      return Response.build(message: _responseMessage);
    } on ApiException catch (ex) {
      idle;

      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;

      return Response.build(status: false, message: 'Lists not deleted');
    }
  }

  Future<void> countSelectedList() async {
    busy;
    int _counter = 0;
    for (ShoppingListModel list in _response.data) {
      if (list.selected) _counter++;
    }
    _selectedElementsCounter = _counter;
    idle;
  }

  void setIsAllSelected() {
    _isAllElementSelected = (listSize == selectedElementsCounter);
  }

  Future<HttpResponse> getMissingItemsFromList() async {
    HttpResponse _response = await locator<ItemViewModel>().getAll();

    List<Map<String, dynamic>> _items = [];

    _response.data.forEach((dynamic item) {
      bool _inList = false;

      _responseListItems.data.forEach((ItemModel itemInList) {
        if (itemInList.id == item['_id'] &&
            itemInList.category != ItemConstants.itemGroupTitle) {
          _inList = true;
        }
      });

      if (!_inList) _items.add(item);
    });

    _response.data = ItemViewModel.orderItemsByCategories(items: _items);

    return _response;
  }

  Future<HttpResponse> saveMissingItemsToShoppingList({String listId}) async {
    busy;
    try {
      ItemViewModel _itemViewModel = locator<ItemViewModel>();

      List<ItemModel> _items = _itemViewModel.selectedShoppingListItems;

      final String _responseMessage =
          await _service.addItemsToList(listId: listId, items: _items);

      _responseListItems.data.addAll(_items);

      _reorganiseListItems(listId: listId);

      _response.data.forEach((ShoppingListModel list) {
        if (list.id == listId) {
          list.itemsCount =
              (list.itemsCount + _itemViewModel.selectedShoppingListItemsCount);
          listItemsCount[listId] = list.itemsCount;
        }
      });

      // _selectedMissingItems.clear();
      _itemViewModel.resetSelectedShoppingListItems();

      idle;
      return Response.build(message: _responseMessage);
    } on ApiException catch (ex) {
      idle;

      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;

      return Response.build(status: false, message: kCouldNotGetItemsMessage);
    }
  }

  Future<void> selectListItem({ItemModel item}) async {
    _responseListItems.data.forEach((ItemModel currentItem) {
      if (currentItem.id == item.id) {
        currentItem.selected = !item.selected;
      }
    });

    _countSelectedItems();

    _checkIfAllItemsAreSelected();

    idle;
  }

  Future<void> selectAllItems() async {
    _responseListItems.data.forEach((ItemModel currentItem) {
      if (currentItem.category != ItemConstants.itemGroupTitle) {
        if (_isAllElementSelected) {
          currentItem.selected = false;
        } else {
          currentItem.selected = true;
        }
      }
    });

    _isAllElementSelected = !_isAllElementSelected;

    _countSelectedItems();
    idle;
  }

  Future<void> unSelectAllListItems() async {
    _responseListItems.data.forEach((ItemModel currentItem) {
      currentItem.selected = false;
    });
    _selectedElementsCounter = Numbers.zero;
    _isAllElementSelected = false;
    idle;
  }

  Future<HttpResponse> deleteAllSelectedItems({String listId}) async {
    try {
      String _responseMessage = await _service.deleteItems(
        listId: listId,
        itemIds: _getSelectedItemsIds(),
      );

      _responseListItems.data.removeWhere((ItemModel currentItem) {
        return currentItem.selected;
      });

      unSelectAllListItems();

      _reorganiseListItems(listId: listId);

      _resetListItemsCount(listId: listId);

      _calculateSpent();

      idle;
      return Response.build(message: _responseMessage);
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;
      return Response.build(status: false, message: kCouldNotDeleteItemMessage);
    }
  }

  Future<void> searchListByName({String name}) async {
    busy;
    clearSearchedResults();

    if (name.isEmpty) {
      setIsNotSearching();
      idle;
      return;
    }

    setIsSearching();

    bool _hasResult = false;

    response.data.forEach((ShoppingListModel list) {
      if (list.name.toLowerCase().contains(name.toLowerCase())) {
        if (!searchedItems.contains(list)) searchedItems.add(list);
        _hasResult = true;
      }
    });

    if (!_hasResult) clearSearchedResults();

    idle;
  }

  void clearSearchedResults({bool notify: false}) {
    getSearchedItems.clear();
    if (notify) idle;
  }

  Future<void> keepSelectedMissingItems({ItemModel selectedItem}) async {
    if (selectedItem.selected) {
      // _selectedMissingItems.add(selectedItem);
    } else {
      // _selectedMissingItems.removeWhere((item) => item.id == selectedItem.id);
    }
    idle;
  }

  // Local Methods

  List<String> _getSelectedListsIds() {
    busy;
    List<String> _selectedListsIds = [];

    for (ShoppingListModel list in _response.data) {
      if (list.selected) _selectedListsIds.add(list.id);
    }

    idle;
    return _selectedListsIds;
  }

  Future<void> _removeSelectedListsFromCurrentLists({
    List<String> selectedListIds,
  }) async {
    _response.data.removeWhere((ShoppingListModel currentList) {
      return selectedListIds.contains(currentList.id);
    });
  }

  Future<void> _addNewlyCreatedListToLocalLists({
    Map<String, dynamic> newList,
  }) async {
    final ShoppingListModel _newListFromJson =
        ShoppingListModel.fromJson(json: newList);

    if (hasLists) {
      _response.data.insert(Numbers.zero, _newListFromJson);
    } else {
      _response.data = [_newListFromJson];
    }
  }

  void _calculateSpent() {
    double _spentTotal = Numbers.asDouble(Numbers.zero);

    responseListItems.data.forEach((ItemModel item) {
      if (item.price > Numbers.asDouble(Numbers.zero) && item.bought) {
        _spentTotal = (_spentTotal + (item.price * item.quantity));
      }
    });

    _spent = _spentTotal;
  }

  void _countSelectedItems() {
    int _selectedItemsCounter = 0;

    _responseListItems.data.forEach((ItemModel currentItem) {
      if (currentItem.selected) {
        _selectedItemsCounter++;
      }
    });

    _selectedElementsCounter = _selectedItemsCounter;
  }

  int _countItems() {
    int _counter = 0;
    responseListItems.data.forEach((ItemModel item) {
      if (item.category != ItemConstants.itemGroupTitle) {
        _counter++;
      }
    });
    return _counter;
  }

  void _resetSpent() {
    _spent = Numbers.asDouble(Numbers.zero);
  }

  void _increaseListSpent({String listId}) {
    _response.data.forEach((ShoppingListModel list) {
      if (list.id == listId) {
        list.spent = _spent;
      }
    });
  }

  void _reorganiseListItems({String listId}) {
    List<Map<String, dynamic>> _itemsToJson = ItemModel.itemsToJson(
      items: _responseListItems.data,
      removeSelectedField: false,
      removeTitles: true,
    );

    List<ItemModel> _itemsOrderedByCategories =
        ItemViewModel.orderItemsByCategories(items: _itemsToJson);

    _setListItemsToResponse(items: _itemsOrderedByCategories);
    _saveListItemsToLocal(listId: listId);
  }

  void _saveListItemsToLocal({String listId}) {
    _localListItems[listId] = responseListItems.data;
  }

  void _setListItemsToResponse({List<ItemModel> items}) {
    _responseListItems = Response.build(data: items);
  }

  void _checkIfAllItemsAreSelected() {
    if (_selectedElementsCounter == _countItems()) {
      _isAllElementSelected = true;
    } else {
      if (_isAllElementSelected) _isAllElementSelected = false;
    }
  }

  List<String> _getSelectedItemsIds() {
    List<String> _selectedItemsIds = [];

    _responseListItems.data.forEach((ItemModel currentItem) {
      if (currentItem.selected) _selectedItemsIds.add(currentItem.id);
    });

    return _selectedItemsIds;
  }

  void _resetListItemsCount({String listId}) {
    _response.data.forEach((ShoppingListModel list) {
      if (list.id == listId) {
        list.itemsCount = _countItems();
        listItemsCount[listId] = list.itemsCount;
      }
    });
  }
}
