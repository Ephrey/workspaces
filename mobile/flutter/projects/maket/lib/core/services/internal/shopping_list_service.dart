import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';

class ShoppingListService extends AbstractApi {
  Future<http.Response> create({Map<String, dynamic> shoppingList}) async {
    final Uri _url = this.url(path: AbstractApi.baseShoppingListPath);

    String _token = await LocalStorage.get(HttpHeadersKeys.xToken) ?? '';

    final http.Response _response = await this.post(
      url: _url,
      body: shoppingList,
      headers: {HttpHeadersKeys.xToken: _token},
    );
    return _response;
  }
}
