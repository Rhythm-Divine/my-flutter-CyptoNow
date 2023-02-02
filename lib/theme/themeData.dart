import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.deepPurple[50],
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.deepPurple[50],
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: const TextStyle(color: Colors.black),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromRGBO(16, 13, 34, 1),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Color.fromRGBO(16, 13, 34, 1),
  ),
);
