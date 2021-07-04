import 'package:maket/constants/items.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/services/internal/item_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';
import 'package:maket/utils/numbers.dart';

class ItemViewModel extends BaseViewModel {
  ItemService _itemService = locator<ItemService>();

  HttpResponse _response = Response.build();

  List<dynamic> _localItems = [];

  List<dynamic> get localItems => _localItems;

  bool get hasLocalItems => _localItems.isNotEmpty;

  HttpResponse get response => _response;

  bool get hasItems => _response.data.length > Numbers.zero;

  List<ItemModel> searchedItems = [];

  List<ItemModel> get getSearchedItems => searchedItems;

  bool get hasSearchedResults => searchedItems.isNotEmpty;

  List<ItemModel> _selectedShoppingListItems = [];

  List<ItemModel> get selectedShoppingListItems => _selectedShoppingListItems;

  bool get hasSelectedShoppingListItems =>
      _selectedShoppingListItems.isNotEmpty;

  int get selectedShoppingListItemsCount => _selectedShoppingListItems.length;

  // Methods

  Future<HttpResponse> create({ItemModel item}) async {
    busy;
    try {
      Map<String, dynamic> _newItem =
          await _itemService.create(item: item.toJson());

      _addItemToLocalItems(item: _newItem);
      _resetItemListFromResponse();
      idle;
      return Response.build(message: 'Added ${item.name}');
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;
      return Response.build(status: false, message: 'Unknown Error.');
    }
  }

  Future<HttpResponse> getAll() async {
    busy;
    try {
      List<dynamic> _items = [];

      if (hasLocalItems) {
        _items = localItems;
      } else {
        _items = await _itemService.getAll();
        _localItems = _items;
      }

      _response = Response.build(data: _items);

      idle;
      return _response;
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print(ex);
      idle;
      return Response.build(status: false, message: 'Could not get Items');
    }
  }

  Future<dynamic> getAllItemsGroupedByCategories() async {
    final HttpResponse _response = await getAll();

    if (!_response.status) return _response;

    if (_response.data.first is ItemModel) {
      return _response;
    }

    _response.data = orderItemsByCategories(items: _response.data);

    return _response;
  }

  static List<ItemModel> orderItemsByCategories({List<dynamic> items}) {
    Map<String, List<ItemModel>> _items = {};

    for (Map<String, dynamic> item in items) {
      ItemModel _item = ItemModel.fromJsonListItem(json: item);

      if (_items[_item.category] == null) {
        _items[_item.category] = [_item];
      } else {
        _items[_item.category].add(_item);
      }
    }

    if (_items.isNotEmpty) {
      Map<String, List<ItemModel>> _orderedItems = {};
      List<String> _itemsCategories = _items.keys.toList();
      _itemsCategories.sort();

      for (String category in _itemsCategories) {
        _orderedItems[category] = _items[category];
      }

      _items = _orderedItems;
    }

    List<ItemModel> _itemsGroupedByCategory = [];

    _items.forEach((category, items) {
      ItemModel _itemsTitle = ItemModel(
        name: category,
        category: ItemConstants.itemGroupTitle,
      );

      if (_itemsGroupedByCategory.indexOf(_itemsTitle) < 0) {
        _itemsGroupedByCategory.add(_itemsTitle);
      }

      for (ItemModel item in items) {
        _itemsGroupedByCategory.add(item);
      }
    });

    return _itemsGroupedByCategory;
  }

  Future<void> searchItemByName({String name}) async {
    busy;
    clearSearchedResults();

    if (name.isEmpty) {
      setIsNotSearching();
      idle;
      return;
    }

    setIsSearching();

    bool _hasResult = false;

    response.data.forEach((ItemModel item) {
      if (item.name.toLowerCase().contains(name.toLowerCase())) {
        if (!searchedItems.contains(item) &&
            item.category != ItemConstants.itemGroupTitle) {
          searchedItems.add(item);
        }
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

  Future<void> keepSelectedShoppingListItems({ItemModel tappedItem}) async {
    int _tappedItemIndex = _response.data.indexOf(tappedItem);

    bool _tappedItemState = _response.data[_tappedItemIndex].selected;

    _response.data[_tappedItemIndex].selected = !_tappedItemState;

    if (_tappedItemState) {
      _removeTappedItemFromShoppingList(tappedItem);
    } else {
      _addTappedItemToShoppingList(tappedItem);
    }
    idle;
  }

  void resetSelectedShoppingListItems() {
    _selectedShoppingListItems = [];
  }

  // local helper functions.

  void _removeTappedItemFromShoppingList(ItemModel tappedItem) {
    _selectedShoppingListItems.removeWhere((item) => item.id == tappedItem.id);
  }

  void _addTappedItemToShoppingList(ItemModel tappedItem) {
    _selectedShoppingListItems.add(tappedItem);
  }

  void _resetItemListFromResponse() {
    _response = Response.build();
  }

  void _addItemToLocalItems({Map<String, dynamic> item, bool notify: false}) {
    _localItems.add(item);
    if (notify) idle;
  }
}
