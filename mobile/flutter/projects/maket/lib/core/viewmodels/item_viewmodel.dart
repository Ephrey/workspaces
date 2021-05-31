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
      final _createdItem = await _itemService.create(item: item.toJson());
      idle;
      return Response.build(data: _createdItem, message: 'Item created');
    } on ApiException catch (ex) {
      idle;
      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;
      return Response.build(status: false, message: 'Unknown Error.');
    }
  }

  Future<List<Map<String, dynamic>>> getGroupedByCategory() async {
    return Future.delayed(const Duration(seconds: 2), () {
      Map<String, List<Map<String, dynamic>>> _items = {};

      for (Map<String, dynamic> item in items) {
        if (_items[item['category']] == null) {
          _items[item['category']] = [item];
        } else {
          _items[item['category']].add(item);
        }
      }

      final List<Map<String, dynamic>> _sorted = [];

      _items.forEach((category, items) {
        Map<String, dynamic> title = {'name': category, 'type': 'title'};
        if (_sorted.indexOf(title) < 0) {
          _sorted.add(title);
        }

        for (Map<String, dynamic> item in items) {
          _sorted.add(item);
        }
      });

      return _sorted;
    });
  }
}
