import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    try {
      Uri path = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=30&page=1&sparkline=false");
      var res = await http.get(path);
      var resJson = json.decode(res.body);

      List<dynamic> marketList = (resJson.toList() as List<dynamic>);

      return marketList;
    } catch (e) {
      return [];
    }
  }

  static Future<List<dynamic>> getPrices(String id) async {
    try {
      Uri req = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/$id/market_chart?vs_currency=inr&days=7");
      final res = await http.get(req);
      var decodeResponse = json.decode(res.body);
      List<dynamic> priceList = decodeResponse['prices'] as List<dynamic>;
      return priceList;
    } catch (e) {
      return [];
    }
  }
}
