import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:maket/constants/http_responses.dart';
import 'package:maket/core/services/apis/internal/abstract_api.dart';
import 'package:maket/handlers/exception/api_exception.dart';

class RegisterService extends AbstractApi {
  Future<String> register(Map<String, String> userInfo) async {
    final Uri _url = this.url(path: 'user/');

    final http.Response _response = await http.post(_url,
        body: jsonEncode(userInfo),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (_response.statusCode == Response.success) {
      return _response.headers['x-token'];
    } else {
      print(_response.statusCode);
      throw ApiException(code: _response.statusCode, message: _response.body);
    }
  }
}
