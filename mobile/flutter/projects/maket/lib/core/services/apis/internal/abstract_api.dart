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

  Uri url({String path: '', Map<String, dynamic> params: const {}}) {
    return Uri.http(endpoint, basePath + path, params);
  }

  Future<http.Response> post({
    @required Uri url,
    @required Map<String, dynamic> body,
  }) async {
    final http.Response _response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {HttpHeaders.contentTypeHeader: HttpHeadersKeys.json},
    );
    return _returnResponse(response: _response);
  }

  http.Response _returnResponse({http.Response response}) {
    return (response.statusCode == Response.success)
        ? response
        : throw ApiException(code: response.statusCode, message: response.body);
  }
}
