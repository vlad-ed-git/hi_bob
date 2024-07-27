import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hi_bob/core/utils/k_debug_print.dart';
import 'package:hi_bob/features/games/data/entities/english_russian_sentence_entity.dart';
import 'package:hi_bob/features/games/domain/modals/english_russian_sentence.dart';

Future<Map<int, Map<int,EnglishRussianSentence>>> getLessonToSentencesMap({int? limit}) async {
  final Map<int, Map<int,EnglishRussianSentence>> lessonIdToSentencesMap = {};
  try {
    final String jsonString = await rootBundle
        .loadString('assets/data/english_russian_sentences.json');
    final data = jsonDecode(jsonString) as Map;
    final List<dynamic> lessons = data["data"] as List<dynamic>;
    for (int lessonId = 0; lessonId < lessons.length; lessonId++) {
      final lesson = lessons[lessonId] as List<dynamic>;
      final Map<int, EnglishRussianSentence>  sentencesInLesson = {};
      for(int sentenceId =0; sentenceId < lesson.length; sentenceId++){
        final sentenceJson = lesson[sentenceId] as Map<String, dynamic>;
        final sentence  = EnglishRussianSentenceEntity.fromJson(
          {"lessonNumber": lessonId, "id": sentenceId}..addAll(sentenceJson),
        );
        sentencesInLesson[sentenceId] =sentence;
      }
      lessonIdToSentencesMap[lessonId] = {}..addAll(sentencesInLesson);
      if(limit != null && lessonId >= limit - 1){
        break;
      }
    }
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
  }
  return lessonIdToSentencesMap;
}
