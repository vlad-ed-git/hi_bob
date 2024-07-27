import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hi_bob/core/utils/k_debug_print.dart';
import 'package:hi_bob/features/games/data/entities/english_russian_sentence_entity.dart';
import 'package:hi_bob/features/games/domain/modals/english_russian_sentence.dart';

Future<Map<int, Map<int,EnglishRussianSentence>>> getLessonToSentencesMap({required int lessonNumber}) async {
  final Map<int, Map<int,EnglishRussianSentence>> lessonIdToSentencesMap = {};
  try {
    final String jsonString = await rootBundle
        .loadString('assets/data/english_russian_sentences.json');
    final data = jsonDecode(jsonString) as Map;
    final List<dynamic> allLessons = data["data"] as List<dynamic>;
    final lesson = allLessons[lessonNumber - 1] as List<dynamic>;
    final Map<int, EnglishRussianSentence>  sentencesInLesson = {};
    for(int sentenceId =0; sentenceId < lesson.length; sentenceId++){
      final sentenceJson = lesson[sentenceId] as Map<String, dynamic>;
      final sentence  = EnglishRussianSentenceEntity.fromJson(
        {"lessonNumber": lessonNumber, "id": sentenceId}..addAll(sentenceJson),
      );
      sentencesInLesson[sentenceId] =sentence;
    }
    lessonIdToSentencesMap[lessonNumber] = {}..addAll(sentencesInLesson);
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
  }
  return lessonIdToSentencesMap;
}
