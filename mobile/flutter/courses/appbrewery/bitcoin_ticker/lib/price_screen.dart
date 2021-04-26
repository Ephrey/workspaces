import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String bitcoinRate;
  String ethereumRate;
  String litecoinRate;

  DropdownButton<String> getDropdownButton() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map<DropdownMenuItem<String>>(
        (String currency) {
          return DropdownMenuItem(
            child: Text(currency),
            value: currency,
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getExchangeRateByCurrency();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (int selectedCurrencyIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedCurrencyIndex];
          getExchangeRateByCurrency();
        });
      },
      children: currenciesList.map<Text>((String currency) {
        return Text(currency);
      }).toList(),
    );
  }

  bool isWaiting = false;

  Future<void> getExchangeRateByCurrency() async {
    isWaiting = true;
    try {
      CoinData coinData = CoinData();
      final Map<String, String> rate =
          await coinData.getCurrenciesRate(currency: selectedCurrency);
      isWaiting = false;
      setState(() {
        bitcoinRate = rate['BTC'];
        ethereumRate = rate['ETH'];
        litecoinRate = rate['LTC'];
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getExchangeRateByCurrency();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CryptoCard(
                cryptoCurrency: 'BTC',
                isWaiting: isWaiting,
                bitcoinRate: bitcoinRate,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'ETH',
                isWaiting: isWaiting,
                bitcoinRate: ethereumRate,
                selectedCurrency: selectedCurrency,
              ),
              CryptoCard(
                cryptoCurrency: 'LTC',
                isWaiting: isWaiting,
                bitcoinRate: litecoinRate,
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.cryptoCurrency,
    @required this.isWaiting,
    @required this.bitcoinRate,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String cryptoCurrency;
  final bool isWaiting;
  final String bitcoinRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = ${!isWaiting ? bitcoinRate : '?'} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
