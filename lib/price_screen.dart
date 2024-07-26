import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String bitcoinValue = '?';
  String etcValue = '?';
  String ltcValue = '?';

  void getData() async {
    try {
      double lastPriceBTC = await CoinData().getCoinData(
        crypto: 'BTC',
        currency: selectedCurrency,
      );
      double lastPriceETC = await CoinData().getCoinData(
        crypto: 'ETH',
        currency: selectedCurrency,
      );
      double lastPriceLTC = await CoinData().getCoinData(
        crypto: 'LTC',
        currency: selectedCurrency,
      );
      setState(() {
        bitcoinValue = lastPriceBTC.toStringAsFixed(0);
        etcValue = lastPriceETC.toStringAsFixed(0);
        ltcValue = lastPriceLTC.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('🤑 Coin Ticker'),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CryptoCard(
                  cryptoSymbol: 'BTC',
                  bitcoinValue: bitcoinValue,
                  selectedCurrency: selectedCurrency),
              CryptoCard(
                  cryptoSymbol: 'ETH',
                  bitcoinValue: etcValue,
                  selectedCurrency: selectedCurrency),
              CryptoCard(
                  cryptoSymbol: 'LTC',
                  bitcoinValue: ltcValue,
                  selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: CupertinoPicker(
              itemExtent: 32.0,
              onSelectedItemChanged: (selectedIndex) {
                setState(() {
                  selectedCurrency = currenciesList[selectedIndex];
                  getData();
                });
              },
              children: [
                for (String currency in currenciesList) Text(currency),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
