import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/day_dao.dart';
import 'dao/day_target_dao.dart';
import 'dao/target_dao.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  late Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await _init();
    return _db;
  }

  Future _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'day_targets_database3.db');

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(DayDao().createTableQuery);
          await db.execute(TargetDao().createTableQuery);
          await db.execute(DayTargetDao().createTableQuery);
        });
  }
}
