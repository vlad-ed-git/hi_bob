import 'dart:convert';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hi_bob/core/translations/domain/models/supported_languages.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preferences_entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
)
@CopyWith()
class UserPreferencesEntity extends UserPreferences {
  static const String languageField = 'language';
  static const String prefersDarkModeField = 'prefersDarkMode';

  @override
  @JsonKey(name: languageField)
  final SupportedLanguages language;

  @override
  @JsonKey(name: prefersDarkModeField)
  final bool prefersDarkMode;

  UserPreferencesEntity({
    required this.language,
    required this.prefersDarkMode,
  }) : super(
          language: language,
          prefersDarkMode: prefersDarkMode,
        );

  @override
  List<Object> get props => [
        language,
        prefersDarkMode,
      ];

  static String tableName = 'user_preferences';
  static String createTableQuery = ""
      "CREATE TABLE $tableName ( id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "$languageField TEXT, "
      "$prefersDarkModeField INTEGER )";

  factory UserPreferencesEntity.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesEntityToJson(this);

  Map<String, Object?> toTableRow() {
    final Map<String, dynamic> json = {};
    json[UserPreferencesEntity.languageField] =
        jsonEncode(language.languageCode);
    json[UserPreferencesEntity.prefersDarkModeField] = prefersDarkMode ? 1 : 0;
    return json;
  }

  factory UserPreferencesEntity.fromTableRow(Map<String, Object?> row) {
    final Map<String, dynamic> json = {};
    json.addAll(row);
    final String languageCode =
        jsonDecode(json[UserPreferencesEntity.languageField]);
    final bool prefersDarkMode =
        json[UserPreferencesEntity.prefersDarkModeField] == 1;
    return UserPreferencesEntity(
      language: SupportedLanguages.values.firstWhere(
        (lang) => lang.languageCode == languageCode,
        orElse: () => SupportedLanguages.defaultLanguage,
      ),
      prefersDarkMode: prefersDarkMode,
    );
  }

  static UserPreferencesEntity fromUserPreferences(
    UserPreferences preferences,
  ) {
    return UserPreferencesEntity(
      language: preferences.language,
      prefersDarkMode: preferences.prefersDarkMode,
    );
  }
}
