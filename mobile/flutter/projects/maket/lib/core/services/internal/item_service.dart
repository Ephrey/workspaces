import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';

class ItemService extends AbstractApi {
  Future<dynamic> create({Map<String, String> item}) async {
    final Uri _url = this.url(path: 'items');
    final _token = await LocalStorage.get(HttpHeadersKeys.xToken);
    final http.Response _response = await this.post(
      url: _url,
      body: item,
      headers: {HttpHeadersKeys.xToken: _token},
    );
    return jsonDecode(_response.body);
  }
}
