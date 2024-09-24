import 'dart:io';

import 'package:gsheets/gsheets.dart';
import 'package:sheets_i18n/arb_serialization.dart';
import 'package:sheets_i18n/extract_messages.dart';
import 'package:yaml/yaml.dart';

main() async {
  final pubspec = File('pubspec.yaml');
  final pubspecContent = await pubspec.readAsString();
  final pubspecMap = loadYaml(pubspecContent);
  final translationMap = pubspecMap['sheets_i18n'];
  final credentialsPath = translationMap['service_account_path'];
  final credentials = await File(credentialsPath).readAsString();
  final sheetId = translationMap['sheet_id'];
  final messagesFile =
      translationMap['localizations_file'] ?? './lib/main.dart';
  final localizationPath = translationMap['localizations_path'] ?? './lib/l10n';

  var sheets = GSheets(
    credentials,
  );
  var doc = await sheets.spreadsheet(sheetId);
  var dir = Directory(localizationPath);
  if (!await dir.exists()) {
    await dir.create();
  }
  for (var sheet in doc.sheets) {
    var context = sheet.title;
    var allColumns = await sheet.values.allColumns();

    var sheetsKeys = allColumns[0].sublist(1);
    for (var col in allColumns.sublist(1)) {
      var locale = col.first;
      var sub = col.sublist(1);
      var values = List.generate(
        sheetsKeys.length,
        (index) => sub.length > index ? sub[index] : '',
      );
      var data = Map.fromIterables(sheetsKeys, values);
      var serializer = ArbSerializer.parse(locale, data, context);
      await File('$localizationPath/intl_$locale.arb')
          .writeAsString(serializer.serialize());

      var messages = extractMessages(messagesFile);
      for (var key in messages.keys) {
        var en = messages[key]?.expanded().replaceFirst('Literal(', '');
        if (en?.endsWith(')') == true) {
          en = en!.substring(0, en.length - 1);
        }
        print('$key -> $en');
        if (!sheetsKeys.contains(key)) {
          await sheet.values.appendRow([
            key,
            en,
          ]);
        }
      }
    }
  }
  return;
}
