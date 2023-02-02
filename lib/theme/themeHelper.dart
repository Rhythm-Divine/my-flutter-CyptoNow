import '../backend/data.dart';
import 'package:flutter/material.dart';

class ThemeHelper with ChangeNotifier {
  late ThemeMode themeMode;

  ThemeHelper(String theme) {
    if (theme == "light") {
      themeMode = ThemeMode.light;
    } else {
      themeMode = ThemeMode.dark;
    }
  }

  void changeTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await savedData.changeTheme("dark");
    } else {
      themeMode = ThemeMode.light;
      await savedData.changeTheme("light");
    }
    notifyListeners();
  }
}
