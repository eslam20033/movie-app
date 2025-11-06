import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  void changeLanguage(String langCode) {
    _currentLocale = Locale(langCode);
    notifyListeners();
  }
}
