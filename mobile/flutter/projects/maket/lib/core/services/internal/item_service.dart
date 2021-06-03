import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';

class ItemService extends AbstractApi {
  Future<Map<String, dynamic>> create({Map<String, dynamic> item}) async {
    final Uri _url = this.url(path: AbstractApi.baseItemPath);

    final String _token = await LocalStorage.get(HttpHeadersKeys.xToken);

    final http.Response _response = await this.post(
      url: _url,
      body: item,
      headers: {HttpHeadersKeys.xToken: _token},
    );

    return jsonDecode(_response.body);
  }

  Future<dynamic> getAll() async {
    final Uri _url = this.url(path: AbstractApi.baseItemPath);

    final String _token = await LocalStorage.get(HttpHeadersKeys.xToken);

    final http.Response _response = await this.get(
      url: _url,
      headers: {HttpHeadersKeys.xToken: _token},
    );

    return jsonDecode(_response.body);
  }
}
