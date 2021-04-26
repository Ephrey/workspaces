import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String _apiKey = '69AB52D6-2590-4AB1-80F7-726E3CA570A1';

class CoinData {
  Future<Map<String, String>> getCurrenciesRate({String currency}) async {
    final Map<String, String> rates = {};

    for (final String crypto in cryptoList) {
      final Uri url = _getUrl(crypto: crypto, currency: currency);

      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final double rate = data['rate'];
        rates.addAll({crypto: rate.toStringAsFixed(0)});
      } else {
        throw 'Could not get the rate';
      }
    }

    return rates;
  }

  Uri _getUrl({String crypto, String currency: 'USD'}) {
    return Uri.https(
      'rest.coinapi.io',
      'v1/exchangerate/$crypto/$currency',
      {'apikey': _apiKey},
    );
  }
}
