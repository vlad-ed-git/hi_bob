
import 'package:hi_bob/features/games/data/local/english_russian_sentences.dart';
import 'package:hi_bob/features/games/domain/keys/matching_words_keys.dart';

import 'package:hi_bob/features/games/domain/modals/english_russian_sentence.dart';
import 'package:hi_bob/features/services/local_storage.dart';

class RussianEnglishSentencesStateController {
  static RussianEnglishSentencesStateController? _instance;

  factory RussianEnglishSentencesStateController() {
    _instance ??= RussianEnglishSentencesStateController._internal();
    LocalStorageServices();
    return _instance!;
  }

  RussianEnglishSentencesStateController._internal();

  static RussianEnglishSentencesStateController get instance => _instance!;
  static LocalStorageServices get _localStorage =>
      LocalStorageServices.instance;

  int _lessonNumber = 1;
  int _sentenceNumber = 1;

  List<EnglishRussianSentence> _currentLessonSentences = [];


  Future<void> initialize({
    int? lessonNumber,
  }) async {
    bool resume = lessonNumber == null;
    if (resume) {
      _lessonNumber = await _localStorage.getInt(MatchingSentencesKeys.lastLessonNumberKey.key) ?? 1;
      _sentenceNumber = await _localStorage.getInt(MatchingSentencesKeys.lastSentenceNumberInLessonKey.key) ?? 1;
    }else {
      _lessonNumber = lessonNumber;
      _sentenceNumber = 1;
    }
    _currentLessonSentences =   await getSentencesInLesson(
      _lessonNumber,
    );
    /// save settings
    await _cacheGame();
    await _setCurrentLessonSentence();
  }

  Future<void> _cacheGame() async{
    await _localStorage.setInt(MatchingSentencesKeys.lastLessonNumberKey.key, _lessonNumber);
    await _localStorage.setInt(MatchingSentencesKeys.lastSentenceNumberInLessonKey.key, _sentenceNumber);
  }

  EnglishRussianSentence? _currentSentence;
  EnglishRussianSentence? get currentSentence => _currentSentence;

  bool reachedEndOfLesson = false;
  Future<void> _setCurrentLessonSentence() async{
    final int currentSentenceIndex = _sentenceNumber - 1;
    reachedEndOfLesson = currentSentenceIndex >= _currentLessonSentences.length;
    if(reachedEndOfLesson){
        _sentenceNumber--;
        await _localStorage.addToIntList(MatchingSentencesKeys.completedLessonsListKey.key, _lessonNumber);
        return;
    }
    _currentSentence = _currentLessonSentences[currentSentenceIndex];
    _englishWordsToMatch = _currentSentence?.shuffledEnglishWords ?? [];
  }

  String get russianSentence => _currentSentence?.russian ?? '-';
  List<String> _englishWordsToMatch = [];
  List<String> get englishWordsToMatch => _englishWordsToMatch;
  Future<void> moveToNextSentence() async{
    clickedWordsForCurrentSentence.clear();
    _sentenceNumber = _sentenceNumber + 1;
    await _setCurrentLessonSentence();
    await _cacheGame();
  }

  int get _totalSentences => _currentLessonSentences.length;
  String get currentSentenceNumberForDisplay => '$_sentenceNumber/$_totalSentences';






  Set<EnglishRussianSentence> _wrongSentences = Set();
  int get wrongSentencesCount => _wrongSentences.length;


  /// use list because we need to track the order of clicked words
  List<String> clickedWordsForCurrentSentence  = [];

  SentenceMatchingResult checkIfSentenceIsMatched() {
        final bool allWordsUsed  = englishWordsToMatch.length == clickedWordsForCurrentSentence.length;
        if(!allWordsUsed)
          return SentenceMatchingResult.waiting; // wait until all words have been used
        final forSentence = _currentSentence;
        if(forSentence == null){
          return SentenceMatchingResult.matchedWrong;
        }
        final bool isCorrectMatch = forSentence.isCorrectEnglish(clickedWordsForCurrentSentence);
        if(!isCorrectMatch){
          _wrongSentences.add(forSentence);
        }
        return isCorrectMatch ?
            SentenceMatchingResult.matchedCorrectly
              : SentenceMatchingResult.matchedWrong;
  }

  void disposeStateData() {
    reachedEndOfLesson = false;
    _currentSentence = null;
    _englishWordsToMatch = [];
    _wrongSentences.clear();
    clickedWordsForCurrentSentence.clear();
    _lessonNumber = 0;
    _sentenceNumber = 0;
  }

}

enum SentenceMatchingResult{
  waiting,
  matchedWrong,
  matchedCorrectly;
}
