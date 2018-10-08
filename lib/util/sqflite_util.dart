import 'dart:async';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:logging/logging.dart';

class SqfliteUtil {
  final Logger logger = Logger('SqfliteUtil');
  static final SqfliteUtil _singleton = new SqfliteUtil._internal();
  SqfliteAdapter _adapter;

  SqfliteUtil._internal();

  factory SqfliteUtil() {
    return _singleton;
  }

  Future<SqfliteAdapter> getAdapter() async {
    String dbPath = await getDatabasesPath();
    _adapter = new SqfliteAdapter(path.join(dbPath, "cinematic_flutter.db"));
    await _adapter.connect();
    return _adapter;
  }

  close() async {
    if (_adapter != null && _adapter.connection != null) {
      await _adapter.close();
    }
  }
}
