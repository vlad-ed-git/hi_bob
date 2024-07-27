import 'package:equatable/equatable.dart';

class EnglishRussianSentence extends Equatable {
  final int id, lessonNumber;
  final String russian, english, audioName;

  EnglishRussianSentence({
    required this.id,
    required this.lessonNumber,
    required this.russian, required this.english, required this.audioName,
  });

  @override
  List<Object> get props => [id, russian, english, lessonNumber,];

  @override
  String toString() {
    return 'EnglishRussianSentence{id: $id, lessonNumber: $lessonNumber, russian: $russian, english: $english, audioName: $audioName}';
  }

  List<String> get russianWords {
    return russian.split(' ').toList(growable: false);
  }
  List<String> get englishWords {
    return english.split(' ').toList(growable: false);
  }

  List<String> get shuffledRussianWords {
    final List<String> shuffledRussianWords = [];
    shuffledRussianWords.addAll(russianWords);
    shuffledRussianWords.shuffle();
    return shuffledRussianWords;
  }

  List<String> get shuffledEnglishWords {
    final List<String> shuffledEnglishWords = [];
    shuffledEnglishWords.addAll(englishWords);
    shuffledEnglishWords.shuffle();
    return shuffledEnglishWords;
  }

  bool isCorrectEnglish(List<String> englishWords){
    return englishWords.join(' ') == english;
  }

  bool isCorrectRussian(List<String> russianWords){
    return russianWords.join(' ') == russian;
  }
}