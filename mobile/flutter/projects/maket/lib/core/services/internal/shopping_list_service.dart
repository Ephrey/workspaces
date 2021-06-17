import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';

class ShoppingListService extends AbstractApi {
  Future<Map<String, dynamic>> create({
    Map<String, dynamic> shoppingList,
  }) async {
    final http.Response _response = await this.post(
      url: this.url(path: AbstractApi.baseShoppingListPath),
      body: shoppingList,
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );

    return jsonDecode(_response.body);
  }

  Future<List<dynamic>> getAllListBodies() async {
    final http.Response _response = await this.get(
      url: this.url(path: AbstractApi.shoppingListBodiesPath),
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );

    return jsonDecode(_response.body);
  }

  Future<List<dynamic>> getItemsById({String listId}) async {
    final http.Response _response = await this.get(
      url: this.url(path: AbstractApi.baseShoppingListPath + '/$listId/items'),
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );

    return jsonDecode(_response.body)['items'];
  }

  Future<String> deleteMany({List<String> listIds}) async {
    final http.Response _response = await this.delete(
      url: this.url(path: AbstractApi.shoppingDeleteManyPath),
      body: {'listIds': listIds},
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );

    return _response.body;
  }
}
