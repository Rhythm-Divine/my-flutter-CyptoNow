import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class savedData {
  static Future<bool> changeTheme(String theme) async {
    SharedPreferences spChangeTheme = await SharedPreferences.getInstance();

    bool result = await spChangeTheme.setString("theme", theme);

    return result;
  }

  static Future<String> getTheme() async {
    SharedPreferences spGetTheme = await SharedPreferences.getInstance();

    String? currTheme = spGetTheme.getString("theme");
    if (currTheme == null) {
      return "light";
    }
    return currTheme;
  }

  static Future<bool> addFavorite(String id) async {
    SharedPreferences spAddFav = await SharedPreferences.getInstance();
    List<String> favoriteList = spAddFav.getStringList("favorites") ?? [];
    favoriteList.add(id);

    return await spAddFav.setStringList("favorites", favoriteList);
  }

  static Future<bool> deleteFavorite(String id) async {
    SharedPreferences spDeleteFav = await SharedPreferences.getInstance();
    List<String> favoriteList = spDeleteFav.getStringList("favorites") ?? [];
    favoriteList.remove(id);

    return await spDeleteFav.setStringList("favorites", favoriteList);
  }

  static Future<List<String>> getFavorite() async {
    SharedPreferences spGetFav = await SharedPreferences.getInstance();
    return spGetFav.getStringList("favorites") ?? [];
  }
}
