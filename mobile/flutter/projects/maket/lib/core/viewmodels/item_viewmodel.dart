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

  HttpResponse get response => _response;

  bool get hasItems => _response.data.length > Numbers.zero;

  Future<HttpResponse> create({ItemModel item}) async {
    busy;
    try {
      await _itemService.create(item: item.toJson());
      _resetLocalItemList();
      idle;
      return Response.build(message: 'Item created');
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
      final List<dynamic> _items = await _itemService.getAll();

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

  // local helper functions.

  void _resetLocalItemList() {
    _response = Response.build();
  }
}
