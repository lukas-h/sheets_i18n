import 'dart:io';

import 'package:intl_translation/extract_messages.dart';
import 'package:intl_translation/src/intl_message.dart';

Map<String, MainMessage> extractMessages(String filename) {
  var extraction = MessageExtraction()
    ..suppressLastModified = false
    ..suppressWarnings = false
    ..suppressMetaData = false
    ..warningsAreErrors = false
    ..allowEmbeddedPluralsAndGenders = true
    ..includeSourceText = false;

  return extraction.parseFile(File(filename), false);
}
