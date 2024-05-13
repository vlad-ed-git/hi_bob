import 'package:hi_bob/core/translations/domain/models/translatable_string.dart';
import 'package:json_annotation/json_annotation.dart';

part 'translatable_string_entity.g.dart';

@JsonSerializable()
class TranslatableStringEntity extends TranslatableString {
  static const String languageCodeField = 'languageCode';
  static const String contentField = 'content';

  @override
  @JsonKey(name: languageCodeField)
  final String languageCode;
  @override
  @JsonKey(name: contentField)
  final String content;

  const TranslatableStringEntity({
    required this.languageCode,
    required this.content,
  }) : super(
          languageCode: languageCode,
          content: content,
        );

  factory TranslatableStringEntity.fromJson(Map<String, dynamic> json) =>
      _$TranslatableStringEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TranslatableStringEntityToJson(this);

  /// Creates a [TranslatableStringEntity] from a domain object
  factory TranslatableStringEntity.fromTranslatableString(
    TranslatableString domainField,
  ) {
    return TranslatableStringEntity(
      content: domainField.content,
      languageCode: domainField.languageCode,
    );
  }

  @override
  List<Object?> get props => [languageCode, content];

  @override
  bool? get stringify => false;

  @override
  String toString() {
    return 'TranslatableStringEntity{languageCode: $languageCode, content: $content}';
  }
}
