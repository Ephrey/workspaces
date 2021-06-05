import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';

class ShoppingListService extends AbstractApi {
  Future<http.Response> create({Map<String, dynamic> shoppingList}) async {
    final Uri _url = this.url(path: AbstractApi.baseShoppingListPath);

    final http.Response _response = await this.post(
      url: _url,
      body: shoppingList,
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );
    return _response;
  }

  Future<List<dynamic>> getAll() async {
    final Uri _url = this.url(path: AbstractApi.baseShoppingListPath);

    final http.Response _response = await this.get(
      url: _url,
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );

    return jsonDecode(_response.body);
  }
}
