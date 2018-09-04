import 'package:cinematic_flutter/common/localizations_keys.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:cinematic_flutter/common/localizations_keys.dart';
import 'package:json_annotation/json_annotation.dart';

part 'messages_en.g.dart';

final messages = MessageLookup();

typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => LocalizationsKeys.EN_KEY;
  final msg = _messages.map(
    (key, value) => MapEntry(key, MessageLookupByLibrary.simpleMessage(value)),
  );

  @override
  Map<String, dynamic> get messages => msg;
}

@JsonLiteral('../language/en.json')
Map<String, dynamic> get _messages => _$_messagesJsonLiteral;
