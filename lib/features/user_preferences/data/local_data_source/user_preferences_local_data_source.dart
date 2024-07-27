import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';

abstract class UserPreferencesLocalSource {
  Future<void> saveUserPreferences(UserPreferences preferences);

  Future<UserPreferences?> getUserPreferences();

  Stream<UserPreferences?> listenToUserPreferencesChanges();

  void dispose();
}
