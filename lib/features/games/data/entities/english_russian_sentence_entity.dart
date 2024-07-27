import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hi_bob/features/games/domain/modals/english_russian_sentence.dart';
import 'package:json_annotation/json_annotation.dart';

part 'english_russian_sentence_entity.g.dart';

@JsonSerializable(
  explicitToJson: true,
  anyMap: true,
)
@CopyWith()
class EnglishRussianSentenceEntity extends EnglishRussianSentence {
  @override
  final int id;
  @override
  final int lessonNumber;
  @override
  final String russian;
  @override
  final String english;
  @override
  final String audioName;

  EnglishRussianSentenceEntity({
    required this.id,
    required this.lessonNumber,
    required this.russian,
    required this.english,
    required this.audioName,
  }) : super(
          id: id,
          lessonNumber: lessonNumber,
          russian: russian,
          english: english,
          audioName: audioName,
        );

  factory EnglishRussianSentenceEntity.fromJson(Map<String, dynamic> json) =>
      _$EnglishRussianSentenceEntityFromJson(json);
  
  Map<String, dynamic> toJson() => _$EnglishRussianSentenceEntityToJson(this);
}
