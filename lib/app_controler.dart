import 'package:flutter/material.dart';

class AppControler extends ChangeNotifier {

  static AppControler instance = AppControler();

  bool DarkTheme = false;
  
  mudarTema() {
    DarkTheme = !DarkTheme;
    notifyListeners();
  }
}