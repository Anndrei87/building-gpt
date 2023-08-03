import 'package:flutter/material.dart';

class LocalizationProvider with ChangeNotifier {
  var _locale = const Locale('pt');

  Locale get getLocale => _locale;

  void changeLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}
