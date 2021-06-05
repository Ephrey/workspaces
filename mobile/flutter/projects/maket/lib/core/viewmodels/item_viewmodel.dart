import 'package:maket/constants/items.dart';
import 'package:maket/core/models/item_model.dart';
import 'package:maket/core/services/internal/item_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';

class ItemViewModel extends BaseViewModel {
  ItemService _itemService = locator<ItemService>();

  Future<HttpResponse> create({ItemModel item}) async {
    busy;
    try {
      await _itemService.create(item: item.toJson());
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
      idle;
      return Response.build(data: _items);
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      print(ex);
      idle;
      return Response.build(status: false, message: 'Could not get Items');
    }
  }

  Future<HttpResponse> getShoppingListItemsGroupedByCategory() async {
    final HttpResponse _response = await getAll();

    if (!_response.status) return _response;

    Map<String, List<ItemModel>> _items = {};

    for (Map<String, dynamic> item in _response.data) {
      ItemModel _item = ItemModel.fromJsonListItem(json: item);

      if (_items[_item.category] == null) {
        _items[_item.category] = [_item];
      } else {
        _items[_item.category].add(_item);
      }
    }

    final List<ItemModel> _itemsGroupedByCategory = [];

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

    _response.data = _itemsGroupedByCategory;
    return _response;
  }
}
