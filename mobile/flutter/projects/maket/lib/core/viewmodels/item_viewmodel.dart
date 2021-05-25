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
}
