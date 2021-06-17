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

  HttpResponse get response => _response;

  HttpResponse get responseListItems => _responseListItems;

  int _selectedListCounter = Numbers.zero;

  bool _isAllListSelected = false;

  double _spent = Numbers.asDouble(Numbers.zero);

  int get getSelectedListCounter => _selectedListCounter;

  bool get hasLists => listSize > Numbers.zero;

  bool get hasItems => itemsSize > Numbers.zero;

  int get listSize => response.data.length;

  int get itemsSize => responseListItems.data.length;

  bool get isAllSelected => _isAllListSelected;

  String get getSpent => _spent.toStringAsFixed(2);

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
      _response =
          Response.build(status: false, message: 'Failed to get Lists.');

      idle;
    }
  }

  Future<void> getListItems({String listId}) async {
    busy;
    try {
      List<ItemModel> _items = ItemViewModel.orderItemsByCategories(
        items: await _service.getItemsById(listId: listId),
      );

      _responseListItems = Response.build(data: _items);
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

  Future<HttpResponse> setListItemPrice({ItemModel item}) async {
    // return Future.delayed(Duration(seconds: 3), () {
    //   print(item.id);
    //   print(item.price);
    //   print(item.quantity);
    //   return Response.build();
    //
    //   return Response.build();
    // });

    try {
      _responseListItems.data.forEach((ItemModel currentItem) {
        if (currentItem.id == item.id) {
          currentItem.price = item.price;
          currentItem.quantity = item.quantity;
          currentItem.bought = true;
          currentItem.selected = true;
        }
      });

      _calculateSpent();

      idle;
      return Response.build(message: 'Item Price Set');
    } on ApiException catch (ex) {
      print('api ex. ${ex.message}');
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print(ex);
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
    _isAllListSelected = false;
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

      final String _response = await _service.deleteMany(listIds: _listIds);

      await _removeSelectedListsFromCurrentLists(selectedListIds: _listIds);

      idle;
      return Response.build(message: _response);
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
    _selectedListCounter = _counter;
    idle;
  }

  void setIsAllSelected() {
    _isAllListSelected = (listSize == getSelectedListCounter);
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

    (hasLists)
        ? _response.data.insert(Numbers.zero, _newListFromJson)
        : response.data = [_newListFromJson];
  }

  void _calculateSpent() {
    responseListItems.data.forEach((ItemModel item) {
      if (item.selected && item.price > 0.0 && item.bought) {
        _spent = (_spent + item.price);
      }
    });
  }
}
