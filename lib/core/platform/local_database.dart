import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDatabaseKey {
  static const database = 'database';
  static const offline = 'offline';
}

class LocalDatabase {
  static LocalDatabase? _instance;

  LocalDatabase._();

  static LocalDatabase get instance => _instance ??= LocalDatabase._();

  Box? _database;

  Future<void> setOffline(bool isOffline) async {
    await _database?.put(LocalDatabaseKey.offline, isOffline);
  }

  Future<bool> get isOffline async {
    _database ??= await Hive.openBox(LocalDatabaseKey.database);

    return _database?.get(LocalDatabaseKey.offline, defaultValue: false) ?? false;
  }
}
