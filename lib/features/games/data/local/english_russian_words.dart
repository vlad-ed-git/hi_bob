import 'package:hi_bob/features/games/data/local/english_words.dart';
import 'package:hi_bob/features/games/data/local/russian_words.dart';

final _englishLowerCase = englishWords.map((e) => e.toLowerCase().trim()).toList(
      growable: false,
    );
const int minBatchLength = 25;

Map<String, List<String>> getEnglishToRussianMatches() {
  final Map<String, List<String>> englishToRussian = {};
  final int totalWords = _englishLowerCase.length;
  for (int i = 0; i < 25; i++) {
    final englishWord = _englishLowerCase[i];
    final russianWord = russianWords[i];
    if (englishToRussian.containsKey(englishWord)) {
      englishToRussian[englishWord]!.add(
        russianWord,
      );
    } else {
      englishToRussian[englishWord] = [russianWord];
    }
  }
  return englishToRussian;
}
Map<String, List<String>> getRussianToEnglishMatches() {
  final Map<String, List<String>> russianToEnglish = {};
  final int totalWords = _englishLowerCase.length;
  for (int i = 0; i < 25; i++) {
    final englishWord = _englishLowerCase[i];
    final russianWord = russianWords[i];
    if (russianToEnglish.containsKey(russianWord)) {
      russianToEnglish[russianWord]!.add(
       englishWord,
      );
    } else {
      russianToEnglish[russianWord] = [englishWord];
    }
  }
  return russianToEnglish;
}


