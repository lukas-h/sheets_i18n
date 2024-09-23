import 'dart:io';

import 'package:intl_translation/extract_messages.dart';
import 'package:intl_translation/src/messages/main_message.dart';

Map<String, MainMessage> extractMessages(String filename) {
  var extraction = MessageExtraction()
        ..suppressWarnings = false
        ..warningsAreErrors = false
        ..allowEmbeddedPluralsAndGenders = true
      // TODO..suppressLastModified = false
      // TODO ..suppressMetaData = false
      // TODO ..includeSourceText = false
      // TODO set ignoredErrorCodes
      ;

  return extraction.parseFile(File(filename), false);
}
