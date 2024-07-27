import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hi_bob/core/utils/k_debug_print.dart';

Future<List<String>> _getRussianWordsInLesson(int lessonNumber) async {
  try {
    final String jsonString = await rootBundle
        .loadString('assets/data/russian_words_by_lesson.json');
    final data = jsonDecode(jsonString) as Map;
    final List<dynamic> lessons = data["data"] as List<dynamic>;
    return (lessons[lessonNumber - 1] as List<dynamic>)
    .map((e) => e.toString()).toList();
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
    return [];
  }
}

Future<List<String>> _getAllRussianWords() async {
  try {
    final String jsonString = await rootBundle
        .loadString('assets/data/russian_ordered.json');
    final data = jsonDecode(jsonString) as Map;
    final List<String> words = (data["data"] as List<dynamic>).map(
        (entry) => entry.toString()
    ).toList();
    return words;
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
    return [];
  }
}

Future<List<String>> _getAllEnglishWords() async {
  try {
    final String jsonString = await rootBundle
        .loadString('assets/data/english_ordered.json');
    final data = jsonDecode(jsonString) as Map;
    final List<String> words = (data["data"] as List<dynamic>).map(
            (entry) => entry.toString()
    ).toList();
    return words;
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
    return [];
  }
}

Future<Map<String, String>> getLessonWordsRussianToEnglish(int lessonNumber)  async {
  try {
    final allRussianWords = await _getAllRussianWords();
    final allEnglishWords = await _getAllEnglishWords();
    final Map<String, String> russianToEnglish = {};
    for(int i = 0; i < allRussianWords.length; i++){
      russianToEnglish[allRussianWords[i]] = allEnglishWords[i];
    }
    final russianWordsInLesson = await _getRussianWordsInLesson(lessonNumber);
    final Map<String, String> russianToEnglishInLesson = {};
    for(String word in russianWordsInLesson){
      if(russianToEnglish.containsKey(word)) {
        russianToEnglishInLesson[word] = russianToEnglish[word]!;
      }
    }
    return russianToEnglishInLesson;
  } on Exception catch (error, st) {
    kDebugPrint('==================| $error, $st');
    return {};
  }
}



