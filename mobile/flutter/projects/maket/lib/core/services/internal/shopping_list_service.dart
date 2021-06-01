import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';

class ShoppingListService extends AbstractApi {
  Future<http.Response> create({Map<String, dynamic> shoppingList}) async {
    final Uri _url = this.url(path: AbstractApi.baseShoppingListPath);
    final http.Response _response =
        await this.post(url: _url, body: shoppingList);
    return _response;
  }
}
