import 'package:hi_bob/core/translations/domain/models/supported_languages.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';

class FlavorConfig {
  final String appTitle;
  final String apiEndpoint;
  final String packageName;
  final bool isDevelopment;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required String appTitle,
    required String apiEndpoint,
    required String packageName,
    required bool isDevelopment,
  }) {
    _instance ??= FlavorConfig._internal(
      appTitle,
      apiEndpoint,
      packageName,
      isDevelopment,
    );
    return _instance!;
  }

  FlavorConfig._internal(
    this.appTitle,
    this.apiEndpoint,
    this.packageName,
    this.isDevelopment,
  );

  static FlavorConfig get instance => _instance!;

  UserPreferences _preferences = UserPreferences();

  UserPreferences get preferences => _preferences;

  set preferences(UserPreferences? value) {
    _preferences = value ?? _preferences;
  }

  bool get isChinese => _preferences.language == SupportedLanguages.chinese;
}
