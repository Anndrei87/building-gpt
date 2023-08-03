import 'package:flutter/material.dart';

import '../widgets/drawer_custom.dart';

class LocalizationProvider with ChangeNotifier {
  var _locale = const Locale('pt');

  LocaleEnum _localeEnum = LocaleEnum.pt;

  LocaleEnum get getEnum => _localeEnum;
  Locale get getLocale => _locale;

  void setLocale(LocaleEnum newLocale) {
    _localeEnum = newLocale;
    notifyListeners();
  }

  void changeLocale(Locale newLocale) {
    _locale = newLocale;

    notifyListeners();
  }
}
