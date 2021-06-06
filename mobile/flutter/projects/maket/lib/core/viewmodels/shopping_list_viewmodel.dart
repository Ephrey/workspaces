import 'package:maket/core/models/shopping_list_model.dart';
import 'package:maket/core/services/internal/shopping_list_service.dart';
import 'package:maket/core/viewmodels/base_viewmodel.dart';
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/locator.dart';

class ShoppingListViewModel extends BaseViewModel {
  final ShoppingListService _shoppingListService =
      locator<ShoppingListService>();

  Future<HttpResponse> create({ShoppingListModel shoppingList}) async {
    busy;
    try {
      await _shoppingListService.create(shoppingList: shoppingList.toJson());

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

  Future<HttpResponse> getAllListBodies() async {
    busy;
    try {
      final List<dynamic> _shoppingListBodies =
          await _shoppingListService.getAllListBodies();

      idle;
      return Response.build(data: _shoppingListBodies);
    } on ApiException catch (ex) {
      idle;

      return Response.build(status: false, code: ex.code, message: ex.message);
    } catch (ex) {
      idle;

      return Response.build(status: false, message: 'Failed to get List.');
    }
  }
}
