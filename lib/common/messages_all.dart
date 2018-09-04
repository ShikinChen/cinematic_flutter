import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';
import 'package:cinematic_flutter/common/localizations_keys.dart';

import 'package:cinematic_flutter/common/messages_en.dart' as messages_en;

typedef Future<dynamic> LibraryLoader();

Map<String, LibraryLoader> _deferredLibraries = {
  LocalizationsKeys.EN_KEY: () => Future.value(null),
};

MessageLookupByLibrary _findExact(localeName) {
  switch (localeName) {
    case LocalizationsKeys.EN_KEY:
      return messages_en.messages;
    default:
      return null;
  }
}

Future initializeMessage(String localeName) async {
  var lib = _deferredLibraries[Intl.canonicalizedLocale(localeName)];
  await (lib == null ? Future.value(false) : lib());
  initializeInternalMessageLookup(() => CompositeMessageLookup());
  messageLookup.addLocale(localeName, _findGeneratedMessagesFor);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary _findGeneratedMessagesFor(locale) {
  var actualLocate =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  return actualLocate == null ? null : _findExact(actualLocate);
}
