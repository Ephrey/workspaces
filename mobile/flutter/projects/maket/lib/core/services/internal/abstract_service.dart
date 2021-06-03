import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';

abstract class AbstractApi {
  static const String endpoint = 'localhost:3000';
  static const String basePath = '/api/';

  static const String baseUserPath = 'user';
  static const String loginPath = (baseUserPath + '/me');

  static const String baseItemPath = 'items';

  static const String baseShoppingListPath = 'shopping_list';

  final Map<String, String> _defaultHeaders = {
    HttpHeaders.contentTypeHeader: HttpHeadersKeys.json,
  };

  Uri url({String path: '', Map<String, dynamic> params: const {}}) {
    return Uri.http(endpoint, basePath + path, params);
  }

  Future<dynamic> post({
    @required Uri url,
    @required Map<String, dynamic> body,
    Map<String, String> headers,
  }) async {
    if (headers != null) _defaultHeaders.addAll(headers);

    final http.Response _response = await http.post(
      url,
      body: jsonEncode(body),
      headers: _defaultHeaders,
    );

    return _returnResponse(response: _response);
  }

  Future<dynamic> get({
    @required Uri url,
    Map<String, String> headers,
  }) async {
    if (headers != null) _defaultHeaders.addAll(headers);

    final http.Response _response = await http.get(
      url,
      headers: _defaultHeaders,
    );

    return _returnResponse(response: _response);
  }

  http.Response _returnResponse({http.Response response}) {
    return (response.statusCode == Response.success)
        ? response
        : throw ApiException(code: response.statusCode, message: response.body);
  }
}
