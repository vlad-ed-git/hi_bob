import 'dart:async';

import 'package:hi_bob/core/caching/domain/sql_dao.dart';
import 'package:hi_bob/core/utils/file_utils.dart';
import 'package:hi_bob/features/user_preferences/data/entities/user_preferences_entity.dart';
import 'package:sqflite/sqflite.dart';

class UserPreferencesSqlDao extends SqlDao {
  static const int _dbVersion = 1;
  static const String _dbName = 'com_hi_bob_user_preferences_sql.db';

  Database? _database;

  @override
  Future<Database> getDb() async {
    _database ??= await _createDatabase();
    return _database!;
  }

  Future<Database> _createDatabase() async {
    final dbDirPath = await getDatabasesPath();
    final path = await createFileAndReturnPathAtDir(dbDirPath, _dbName);
    var db = await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
      version: _dbVersion,
    );
    return db;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute(UserPreferencesEntity.createTableQuery);
  }

  FutureOr<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async =>
      _onWipeAndRecreate(
        db,
        oldVersion,
        newVersion,
      );

  FutureOr<void> _onDowngrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async =>
      _onWipeAndRecreate(
        db,
        oldVersion,
        newVersion,
      );

  FutureOr<void> _onWipeAndRecreate(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    // Delete the old tables
    await db.execute('DROP TABLE IF EXISTS ${UserPreferencesEntity.tableName}');

    // Create the new tables
    await db.execute(UserPreferencesEntity.createTableQuery);
  }
}
