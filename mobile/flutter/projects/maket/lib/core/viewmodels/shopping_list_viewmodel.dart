import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/services/internal/shopping_list_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';

class ShoppingListViewModel extends BaseViewModel {
  final ShoppingListService _service = locator<ShoppingListService>();

  HttpResponse _response = Response.build();

  HttpResponse get response => _response;

  Future<HttpResponse> create({ShoppingListModel shoppingList}) async {
    busy;
    try {
      await _service.create(shoppingList: shoppingList.toJson());

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
      _response = Response.build(data: await _service.getAllListBodies());

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
}
