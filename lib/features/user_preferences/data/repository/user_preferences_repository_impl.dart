import 'package:dartz/dartz.dart';
import 'package:hi_bob/core/error_handling/domain/repository/log_errors.dart';
import 'package:hi_bob/features/user_preferences/data/local_data_source/user_preferences_local_data_source.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_errors.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_exception.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_failure.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';
import 'package:hi_bob/features/user_preferences/domain/repository/user_preferences_repository.dart';

class UserPreferencesRepositoryImpl extends UserPreferencesRepository {
  final UserPreferencesLocalSource _localSource;
  final LogErrors _errorLogger;

  UserPreferencesRepositoryImpl(
    this._localSource,
    this._errorLogger,
  );

  @override
  Future<Either<UserPreferencesFailure, UserPreferences>>
      getUserPreferences() async {
    try {
      final preferences = await _localSource.getUserPreferences();
      if (preferences != null) {
        return Right(preferences);
      }

      final defaultPreferences = UserPreferences();
      await _localSource.saveUserPreferences(defaultPreferences);
      return Right(
        UserPreferences(),
      );
    } on Exception catch (error, st) {
      _errorLogger.log(
        callerClass: 'UserPreferencesRepositoryImpl',
        callerMethod: 'getUserPreferences',
        error: error is UserPreferencesException ? error.error ?? error : error,
        stackTrace:
            error is UserPreferencesException ? error.stackTrace ?? st : st,
        logToServer: true,
      );
      return Left(
        UserPreferencesFailure(
          error is UserPreferencesException
              ? error.userPreferencesError
              : UserPreferencesErrors.unknownUserPreferencesErr,
        ),
      );
    }
  }

  @override
  Future<Either<UserPreferencesFailure, UserPreferences>> setUserPreferences(
    UserPreferences preferences,
  ) async {
    try {
      await _localSource.saveUserPreferences(preferences);
      return Right(preferences);
    } on Exception catch (error, st) {
      _errorLogger.log(
        callerClass: 'UserPreferencesRepositoryImpl',
        callerMethod: 'saveUserPreferences',
        error: error is UserPreferencesException ? error.error ?? error : error,
        stackTrace:
            error is UserPreferencesException ? error.stackTrace ?? st : st,
        logToServer: true,
      );
      return Left(
        UserPreferencesFailure(
          error is UserPreferencesException
              ? error.userPreferencesError
              : UserPreferencesErrors.unknownUserPreferencesErr,
        ),
      );
    }
  }

  @override
  Stream<UserPreferences?> listenToUserPreferencesChanges() {
    try {
      return _localSource.listenToUserPreferencesChanges();
    } on Exception catch (error, st) {
      final err =
          error is UserPreferencesException ? error.error ?? error : error;
      _errorLogger.log(
        callerClass: 'UserPreferencesRepositoryImpl',
        callerMethod: 'saveUserPreferences',
        error: err,
        stackTrace:
            error is UserPreferencesException ? error.stackTrace ?? st : st,
        logToServer: true,
      );
      return Stream.error(err);
    }
  }
}
