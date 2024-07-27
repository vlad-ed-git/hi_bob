import 'dart:async';

import 'package:hi_bob/core/caching/domain/sql_dao.dart';
import 'package:hi_bob/features/user_preferences/data/entities/user_preferences_entity.dart';
import 'package:hi_bob/features/user_preferences/data/local_data_source/user_preferences_local_data_source.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_errors.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_exception.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';
import 'package:sqflite/sqflite.dart';

class UserPreferencesLocalSourceImpl implements UserPreferencesLocalSource {

  UserPreferencesLocalSourceImpl();

  StreamController<UserPreferences?>? _changesStreamController;

  @override
  Future<void> saveUserPreferences(UserPreferences preferences) async {
    try {
      _initListenerStreamIfNull();
      _changesStreamController?.add(preferences);
    } on Exception catch (error, st) {
      throw UserPreferencesException(
        UserPreferencesErrors.unknownUserPreferencesErr,
        error: error,
        stackTrace: st,
      );
    }
  }

  @override
  Future<UserPreferences?> getUserPreferences() async {
    try {
      return null;
    } on Exception catch (error, st) {
      throw UserPreferencesException(
        UserPreferencesErrors.unknownUserPreferencesErr,
        error: error,
        stackTrace: st,
      );
    }
  }

  @override
  Stream<UserPreferences?> listenToUserPreferencesChanges() {
    _initListenerStreamIfNull();
    return _changesStreamController!.stream;
  }

  void _initListenerStreamIfNull() {
    _changesStreamController ??= StreamController.broadcast();
  }

  @override
  void dispose() {
    _changesStreamController?.close();
    _changesStreamController = null;
  }
}
