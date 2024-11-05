import 'dart:convert';

import 'package:intl/locale.dart';

class ArbSerializer {
  final Locale locale;
  final String context;
  final Map<String, String> data;

  ArbSerializer.parse(String localeIdentifier, this.data, this.context)
      : locale = Locale.parse(localeIdentifier);

  String serialize() {
    Map<String, dynamic> result = {
      "@@locale": locale.toLanguageTag().replaceAll('-', '_'),
      "@@last_modified": DateTime.now().toIso8601String(),
      "@@context": context,
    };
    data.forEach((key, value) {
      result.addAll({
        key: value,
        "@$key": {
          "type": "text",
        }
      });
    });
    final encoder = JsonEncoder.withIndent('    ');
    return encoder.convert(result);
  }
}
