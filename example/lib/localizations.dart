import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:example/l10n/messages_all.dart';

class MyAppLocalizations {
  final String localeName;

  MyAppLocalizations(this.localeName);

  String get logistics => Intl.message(
        'Logistics',
        name: 'logistics',
        locale: localeName,
      );

  String get gates => Intl.message(
        'Gates',
        name: 'gates',
        locale: localeName,
      );

  String get warehouse => Intl.message(
        'Warehouse',
        name: 'warehouse',
        locale: localeName,
      );

  static Future<MyAppLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty == true
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      return MyAppLocalizations(localeName);
    });
  }

  static MyAppLocalizations of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations)!;
  }
}

class MyAppLocalizationsDelegate
    extends LocalizationsDelegate<MyAppLocalizations> {
  const MyAppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'cs'].contains(locale.languageCode);

  @override
  Future<MyAppLocalizations> load(Locale locale) =>
      MyAppLocalizations.load(locale);

  @override
  bool shouldReload(MyAppLocalizationsDelegate old) => false;
}
