import 'package:dartz/dartz.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_failure.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';

abstract class UserPreferencesRepository {
  Future<Either<UserPreferencesFailure, UserPreferences>> getUserPreferences();

  Future<Either<UserPreferencesFailure, UserPreferences>> setUserPreferences(
    UserPreferences preferences,
  );

  Stream<UserPreferences?> listenToUserPreferencesChanges();
}
