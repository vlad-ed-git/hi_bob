// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english_russian_sentence_entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EnglishRussianSentenceEntityCWProxy {
  EnglishRussianSentenceEntity id(int id);

  EnglishRussianSentenceEntity lessonNumber(int lessonNumber);

  EnglishRussianSentenceEntity russian(String russian);

  EnglishRussianSentenceEntity english(String english);

  EnglishRussianSentenceEntity audioName(String audioName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EnglishRussianSentenceEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EnglishRussianSentenceEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  EnglishRussianSentenceEntity call({
    int? id,
    int? lessonNumber,
    String? russian,
    String? english,
    String? audioName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEnglishRussianSentenceEntity.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEnglishRussianSentenceEntity.copyWith.fieldName(...)`
class _$EnglishRussianSentenceEntityCWProxyImpl
    implements _$EnglishRussianSentenceEntityCWProxy {
  const _$EnglishRussianSentenceEntityCWProxyImpl(this._value);

  final EnglishRussianSentenceEntity _value;

  @override
  EnglishRussianSentenceEntity id(int id) => this(id: id);

  @override
  EnglishRussianSentenceEntity lessonNumber(int lessonNumber) =>
      this(lessonNumber: lessonNumber);

  @override
  EnglishRussianSentenceEntity russian(String russian) =>
      this(russian: russian);

  @override
  EnglishRussianSentenceEntity english(String english) =>
      this(english: english);

  @override
  EnglishRussianSentenceEntity audioName(String audioName) =>
      this(audioName: audioName);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EnglishRussianSentenceEntity(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EnglishRussianSentenceEntity(...).copyWith(id: 12, name: "My name")
  /// ````
  EnglishRussianSentenceEntity call({
    Object? id = const $CopyWithPlaceholder(),
    Object? lessonNumber = const $CopyWithPlaceholder(),
    Object? russian = const $CopyWithPlaceholder(),
    Object? english = const $CopyWithPlaceholder(),
    Object? audioName = const $CopyWithPlaceholder(),
  }) {
    return EnglishRussianSentenceEntity(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      lessonNumber:
          lessonNumber == const $CopyWithPlaceholder() || lessonNumber == null
              ? _value.lessonNumber
              // ignore: cast_nullable_to_non_nullable
              : lessonNumber as int,
      russian: russian == const $CopyWithPlaceholder() || russian == null
          ? _value.russian
          // ignore: cast_nullable_to_non_nullable
          : russian as String,
      english: english == const $CopyWithPlaceholder() || english == null
          ? _value.english
          // ignore: cast_nullable_to_non_nullable
          : english as String,
      audioName: audioName == const $CopyWithPlaceholder() || audioName == null
          ? _value.audioName
          // ignore: cast_nullable_to_non_nullable
          : audioName as String,
    );
  }
}

extension $EnglishRussianSentenceEntityCopyWith
    on EnglishRussianSentenceEntity {
  /// Returns a callable class that can be used as follows: `instanceOfEnglishRussianSentenceEntity.copyWith(...)` or like so:`instanceOfEnglishRussianSentenceEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EnglishRussianSentenceEntityCWProxy get copyWith =>
      _$EnglishRussianSentenceEntityCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnglishRussianSentenceEntity _$EnglishRussianSentenceEntityFromJson(Map json) =>
    EnglishRussianSentenceEntity(
      id: (json['id'] as num).toInt(),
      lessonNumber: (json['lessonNumber'] as num).toInt(),
      russian: json['russian'] as String,
      english: json['english'] as String,
      audioName: json['audioName'] as String,
    );

Map<String, dynamic> _$EnglishRussianSentenceEntityToJson(
        EnglishRussianSentenceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonNumber': instance.lessonNumber,
      'russian': instance.russian,
      'english': instance.english,
      'audioName': instance.audioName,
    };
