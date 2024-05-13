import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_errors.dart';

class UserPreferencesException implements Exception {
  final UserPreferencesErrors userPreferencesError;
  final dynamic error, stackTrace;

  const UserPreferencesException(
    this.userPreferencesError, {
    this.error,
    this.stackTrace,
  });
}
