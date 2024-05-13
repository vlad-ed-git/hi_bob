// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserPreferencesEntityCWProxy {
  UserPreferencesEntity language(SupportedLanguages language);

  UserPreferencesEntity prefersDarkMode(bool prefersDarkMode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserPreferencesEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserPreferencesEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  UserPreferencesEntity call({
    SupportedLanguages? language,
    bool? prefersDarkMode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserPreferencesEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserPreferencesEntity.copyWith.fieldName(...)`
class _$UserPreferencesEntityCWProxyImpl
    implements _$UserPreferencesEntityCWProxy {
  const _$UserPreferencesEntityCWProxyImpl(this._value);

  final UserPreferencesEntity _value;

  @override
  UserPreferencesEntity language(SupportedLanguages language) =>
      this(language: language);

  @override
  UserPreferencesEntity prefersDarkMode(bool prefersDarkMode) =>
      this(prefersDarkMode: prefersDarkMode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserPreferencesEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserPreferencesEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  UserPreferencesEntity call({
    Object? language = const $CopyWithPlaceholder(),
    Object? prefersDarkMode = const $CopyWithPlaceholder(),
  }) {
    return UserPreferencesEntity(
      language: language == const $CopyWithPlaceholder() || language == null
          ? _value.language
          // ignore: cast_nullable_to_non_nullable
          : language as SupportedLanguages,
      prefersDarkMode: prefersDarkMode == const $CopyWithPlaceholder() ||
              prefersDarkMode == null
          ? _value.prefersDarkMode
          // ignore: cast_nullable_to_non_nullable
          : prefersDarkMode as bool,
    );
  }
}

extension $UserPreferencesEntityCopyWith on UserPreferencesEntity {
  /// Returns a callable class that can be used as follows: `instanceOfUserPreferencesEntity.copyWith(...)` or like so:`instanceOfUserPreferencesEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserPreferencesEntityCWProxy get copyWith =>
      _$UserPreferencesEntityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferencesEntity _$UserPreferencesEntityFromJson(
        Map<String, dynamic> json) =>
    UserPreferencesEntity(
      language: $enumDecode(_$SupportedLanguagesEnumMap, json['language']),
      prefersDarkMode: json['prefersDarkMode'] as bool,
    );

Map<String, dynamic> _$UserPreferencesEntityToJson(
        UserPreferencesEntity instance) =>
    <String, dynamic>{
      'language': _$SupportedLanguagesEnumMap[instance.language]!,
      'prefersDarkMode': instance.prefersDarkMode,
    };

const _$SupportedLanguagesEnumMap = {
  SupportedLanguages.english: 'en',
  SupportedLanguages.chinese: 'zh',
};
