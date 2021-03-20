import 'dart:async';
import 'dart:convert' show utf8, json;
import 'dart:io';

const apiCategory = {"name": "Currency", "route": "currency"};

class Api {
  final _httpClient = HttpClient();
  final _url = 'flutter.udacity.com';

  Future<List> getUnits(String category) async {
    final uri = Uri.https(_url, "/$category");
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['units'] == null) {
      print('Error retrieving units');
      return null;
    }
    return jsonResponse['units'];
  }

  Future<double> convert(
      String category, String from, String to, String amount) async {
    final uri = Uri.https(_url, "/xx$category/convert",
        {'from': from, "to": to, "amount": amount});
    print(uri);
    final jsonResponse = await _getJson(uri);

    if (jsonResponse == null || jsonResponse['status'] == null) {
      print('Error retrieving conversion');
      return null;
    } else if (jsonResponse['status'] == 'error') {
      print(jsonResponse['message']);
      return null;
    }

    return jsonResponse['conversion'].toDouble();
  }

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();

      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();

      return json.decode(responseBody);
    } on Exception catch (e) {
      print("$e");
      return null;
    }
  }
}
