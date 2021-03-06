import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maket/handlers/exception/api_exception.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';
import 'package:maket/utils/local_storage.dart';

abstract class AbstractApi {
  static const String endpoint = '169.254.136.141:3000';
  static const String basePath = '/api/';

  static const String baseUserPath = 'user';
  static const String loginPath = (baseUserPath + '/me');
  static const String verifyEmailPath = (baseUserPath + '/verify_email');
  static const String verifyOtpCodePath = (baseUserPath + '/verify_otp_code');
  static const String updatePasswordPath = (baseUserPath + '/update_password');

  static const String baseItemPath = 'items';

  static const String baseShoppingListPath = 'shopping_list';
  static const String shoppingListBodiesPath = baseShoppingListPath + '/body';
  static const String shoppingDeleteManyPath =
      baseShoppingListPath + '/delete/many';

  final Map<String, String> _defaultHeaders = {
    HttpHeaders.contentTypeHeader: HttpHeadersKeys.json,
  };

  Uri url({String path: '', Map<String, dynamic> params: const {}}) {
    Uri _url = Uri.http(endpoint, (basePath + path), params);
    print(_url);
    return _url;
  }

  Future<http.Response> post({
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

  Future<http.Response> get({
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

  Future<http.Response> delete({
    @required Uri url,
    Map<String, dynamic> body,
    Map<String, String> headers,
  }) async {
    if (headers != null) _defaultHeaders.addAll(headers);

    final http.Response _response = await http.delete(
      url,
      body: jsonEncode(body),
      headers: _defaultHeaders,
    );

    return _returnResponse(response: _response);
  }

  Future<http.Response> put({
    @required Uri url,
    Map<String, dynamic> body: const {},
    Map<String, String> headers,
  }) async {
    if (headers != null) _defaultHeaders.addAll(headers);

    final http.Response _response = await http.put(
      url,
      body: (body.isNotEmpty) ? jsonEncode(body) : null,
      headers: _defaultHeaders,
    );

    return _returnResponse(response: _response);
  }

  http.Response _returnResponse({http.Response response}) {
    return (response.statusCode == Response.success)
        ? response
        : throw ApiException(code: response.statusCode, message: response.body);
  }

  Future<String> getToken() async {
    return await LocalStorage.get(HttpHeadersKeys.xToken) ?? '';
  }
}
