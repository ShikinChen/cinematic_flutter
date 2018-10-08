import 'package:intl/intl.dart';

final ymdFormat = DateFormat('yyyy-MM-dd');
final ymdhmsFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

DateTime toDateTime(String dateTimeStr) {
  if (dateTimeStr != null && dateTimeStr.isNotEmpty) {
    if (dateTimeStr.contains(":")) {
      return ymdhmsFormat.parse(dateTimeStr);
    }
    return ymdFormat.parse(dateTimeStr);
  }
  return null;
}
