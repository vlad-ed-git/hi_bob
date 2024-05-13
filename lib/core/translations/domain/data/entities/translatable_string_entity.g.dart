// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translatable_string_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslatableStringEntity _$TranslatableStringEntityFromJson(
        Map<String, dynamic> json) =>
    TranslatableStringEntity(
      languageCode: json['languageCode'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$TranslatableStringEntityToJson(
        TranslatableStringEntity instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'content': instance.content,
    };
