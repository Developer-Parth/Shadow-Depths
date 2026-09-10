import 'dart:async';

import 'package:shadow_depths/util/localization/my_localizations.dart';
import 'package:shadow_depths/util/localization/languages.dart';
import 'package:flutter/material.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return languageOrder.any((code) {
      String langCode = code.contains('-') ? code.split('-')[0] : code;
      return langCode == locale.languageCode;
    });
  }

  @override
  Future<MyLocalizations> load(Locale locale) async {
    MyLocalizations localizations = MyLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;

  Locale resolution(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) return supportedLocales.first;

    List<Locale> languageMatches = supportedLocales
        .where((l) => l.languageCode == locale.languageCode)
        .toList();

    if (languageMatches.isEmpty) return supportedLocales.first;

    if (locale.countryCode != null) {
      for (Locale match in languageMatches) {
        if (match.countryCode == locale.countryCode) {
          return match;
        }
      }
    }

    return languageMatches.first;
  }

  static List<Locale> supportedLocales() {
    return languageOrder.map((code) => codeToLocale(code)).toList();
  }
}
