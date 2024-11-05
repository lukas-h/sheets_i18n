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

  final sheets = GSheets(credentials);
  final doc = await sheets.spreadsheet(sheetId);
  final dir = Directory(localizationPath);
  if (!await dir.exists()) {
    await dir.create();
  }

  for (final sheet in doc.sheets) {
    final context = sheet.title;
    final allColumns = await sheet.values.allColumns();

    final sheetsKeys = allColumns[0].sublist(1);
    final existingKeys = Set<String>.from(sheetsKeys);

    for (final col in allColumns.sublist(1)) {
      final locale = col.first;
      final sub = col.sublist(1);
      final values = List.generate(
        sheetsKeys.length,
        (index) => sub.length > index ? sub[index] : '',
      );
      final data = Map.fromIterables(sheetsKeys, values);
      final serializer = ArbSerializer.parse(locale, data, context);
      await File('$localizationPath/intl_$locale.arb')
          .writeAsString(serializer.serialize());

      final messages = extractMessages(messagesFile);
      for (final key in messages.keys) {
        var en = messages[key]?.expanded().replaceFirst('Literal(', '');
        if (en?.endsWith(')') == true) {
          en = en!.substring(0, en.length - 1);
        }
        print('$key -> $en');

        if (!existingKeys.contains(key)) {
          await sheet.values.appendRow([key, en]);
          existingKeys.add(key);
        }
      }
    }
  }
}
