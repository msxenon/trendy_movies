import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///just run
///  flutter pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/application/localisation/app_localization.dart
/// localazy upload
/// edit translation online
/// localazy download... thats it
// ignore_for_file: non_constant_identifier_names

class AppLocalization {
  static Future<AppLocalization> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty == true
        ? locale.languageCode
        : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalization();
    });
  }

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  // list of locales
  String get heyWorld {
    return Intl.message(
      'You have pushed the button this many times:',
      name: 'heyWorld',
      desc: 'Simple word for greeting ',
    );
  }
}
