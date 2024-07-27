import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hi_bob/core/utils/k_debug_print.dart';
import 'package:hi_bob/features/games/data/entities/english_russian_sentence_entity.dart';
import 'package:hi_bob/features/games/domain/modals/english_russian_sentence.dart';
Future<List<EnglishRussianSentence>> getSentencesInLesson(int lessonNumber) async {
  try {
    final String jsonString = await rootBundle
        .loadString('assets/data/english_russian_sentences.json');
    final data = jsonDecode(jsonString) as Map;
    final List<dynamic> lessons = data["data"] as List<dynamic>;
    return (lessons[lessonNumber - 1] as List<dynamic>)
        .asMap().entries.map((e) =>
        EnglishRussianSentenceEntity.fromJson(
          { "lessonNumber": lessonNumber,
            "id": e.key}..addAll(e.value as Map<String, dynamic>),
        )
    ).toList();
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
    return [];
  }
}