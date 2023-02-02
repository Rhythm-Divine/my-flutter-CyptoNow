import 'dart:async';
import '../backend/data.dart';
import 'package:flutter/widgets.dart';
import 'package:my_crypto_app/backend/cryptoData.dart';
import 'package:my_crypto_app/backend/prices.dart';
import 'apiHelper.dart';

class MarketHelper with ChangeNotifier {
  bool load = true;
  bool fetch = false;
  List<CryptoData> markets = [];
  List<Price> prices = [];

  MarketHelper() {
    getData();
  }

  Future<void> getData() async {
    // ignore: no_leading_underscores_for_local_identifiers
    List<dynamic> _markets = await API.getMarkets();
    List<String> favorites = await savedData.getFavorite();
    List<CryptoData> list = [];
    for (var market in _markets) {
      CryptoData crypto = CryptoData.fromJson(market);

      if (favorites.contains(crypto.id)) {
        crypto.isFavorites = true;
      }
      list.add(crypto);
    }

    markets = list;
    load = false;
    notifyListeners();
    Timer(const Duration(seconds: 30), () {
      getData();
    });
  }

  CryptoData getCrypto(String id) {
    CryptoData crypto = markets.where((e) => e.id == id).toList()[0];
    return crypto;
  }

  Future<void> getGraph(String data) async {
    if (!fetch) {
      // ignore: no_leading_underscores_for_local_identifiers
      List<dynamic> _prices = await API.getPrices(data);
      List<Price> list = [];

      for (var price in _prices) {
        list.add(Price.fromJson(price));
      }
      prices = list;
      fetch = true;
      notifyListeners();
    }
  }

  Future<void> addFavorite(CryptoData crypto) async {
    int idx = markets.indexOf(crypto);
    markets[idx].isFavorites = true;
    await savedData.addFavorite(crypto.id!);
    notifyListeners();
  }

  Future<void> deleteFavorite(CryptoData crypto) async {
    int idx = markets.indexOf(crypto);
    markets[idx].isFavorites = false;
    await savedData.deleteFavorite(crypto.id!);
    notifyListeners();
  }
}
