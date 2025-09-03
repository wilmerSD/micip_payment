import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool themeDark;

  ThemeProvider({
    required bool darkMode
  }): themeDark = darkMode;

  set getValueTheme(bool value){
    themeDark = value;
    notifyListeners();  
  }
}