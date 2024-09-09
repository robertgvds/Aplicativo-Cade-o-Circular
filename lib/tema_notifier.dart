import 'package:flutter/material.dart';

class TemaNotifier extends ChangeNotifier {
  bool _darkTheme = false;
  ThemeData _themeData = ThemeData.light();

  TemaNotifier() {
    _updateTheme();
  }

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    _updateTheme();
    notifyListeners();
  }

  void _updateTheme() {
    _themeData = _darkTheme
        ? ThemeData.dark().copyWith(
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.black, colorScheme: ColorScheme.dark(primary: Colors.red).copyWith(surface: Colors.black),
          )
        : ThemeData.light().copyWith(
            primaryColor: Colors.red,
            scaffoldBackgroundColor: Colors.white, colorScheme: ColorScheme.light(primary: Colors.red).copyWith(surface: Colors.white),
          );
  }
}
