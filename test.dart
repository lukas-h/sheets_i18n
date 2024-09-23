import 'package:intl/locale.dart';

main() {
  print(Locale.parse('en_US').languageCode);
  print(Locale.parse('en_US').scriptCode);
  print(Locale.parse('en_US').countryCode);
  print(Locale.parse('en_US').variants);
  print(Locale.parse('en').toLanguageTag());
  print(Locale.parse('es').toLanguageTag());
}
