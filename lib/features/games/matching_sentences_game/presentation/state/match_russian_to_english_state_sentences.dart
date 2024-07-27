
import 'package:hi_bob/features/games/data/local/english_russian_sentences.dart';

import 'package:hi_bob/features/games/domain/modals/english_russian_sentence.dart';
import 'package:hi_bob/features/services/local_storage.dart';
import 'package:pinput/pinput.dart';

String _lastLessonNumberKey = 'lastRussianEnglishSentencesLessonNumberKey';
String _lastSentenceNumberInLessonKey = 'lastRussianEnglishSentenceNumberInLessonKey';

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
  int _sentenceNumber = 0;

  Map<int, Map<int, EnglishRussianSentence>> _lessonToSentencesMap = {};
  Future<void> _loadSentencesForLesson() async {
    _lessonToSentencesMap =   await getLessonToSentencesMap(
       lessonNumber: _lessonNumber,
    );
  }

  Future<void> initialize({
    int? lessonNumber,
  }) async {
    bool resume = lessonNumber == null;
    if (resume) {
      _lessonNumber = await _localStorage.getInt(_lastLessonNumberKey) ?? 0;
      _sentenceNumber =
          await _localStorage.getInt(_lastSentenceNumberInLessonKey) ?? 0;
    }
    await _loadSentencesForLesson();

    /// save settings
    await _cacheGame();
    /// load the sentences for current lesson
    _loadLessonSentences();
  }

  Future<void> _cacheGame() async{
    await _localStorage.setInt(_lastLessonNumberKey, _lessonNumber);
    await _localStorage.setInt(_lastSentenceNumberInLessonKey, _sentenceNumber);
  }

  void _loadLessonSentences() {
    _setCurrentLessonSentence();
  }

  bool reachedEndOfGame = false;
  bool reachedEndOfLesson = false;
  Map<int, EnglishRussianSentence> currentLesson = {};
  EnglishRussianSentence? _currentSentence;
  String get russianSentence => _currentSentence?.russian ?? '-';
  List<String> get englishWordsToMatch {
      return _currentSentence?.shuffledEnglishWords ?? [];
  }

  bool get _isEndOfGame => _lessonNumber >= _lessonToSentencesMap.length;
  bool get _isEndOfLesson => _sentenceNumber >= currentLesson.length;
 
  int get _totalLessons => _lessonToSentencesMap.length;
  
  String get currentLessonNumberForDisplay{
    if(reachedEndOfGame){
      return '$_totalLessons/$_totalLessons';
    }
    // since [_lessonNumber] follows zero based index
   return '${_lessonNumber + 1}/$_totalLessons';
  }

  
  String get currentSentenceNumberForDisplay{
    final sentencesInCurrentLesson  = _lessonToSentencesMap[_lessonNumber]?.length ?? _lessonToSentencesMap.values.last.length;
    if(reachedEndOfLesson){
      return '$_sentenceNumber/$sentencesInCurrentLesson';
    }
    // since [_sentenceNumber] follows zero based index
    return  '${_sentenceNumber + 1}/$sentencesInCurrentLesson';
  }

  void _setCurrentLessonSentence() {
    if (_isEndOfGame) {
      reachedEndOfGame = true;
      return;
    }
    currentLesson = _lessonToSentencesMap[_lessonNumber] ?? {};
    if(_isEndOfLesson){
      // reached end of lesson
      reachedEndOfLesson = true;
      return;
    }
    _currentSentence = currentLesson[_sentenceNumber];
  }

  Future<void> goToNextLesson() async{
    _lessonNumber =  _lessonNumber + 1;
    if (!_isEndOfGame) {
      _sentenceNumber = 0;
    }
    _setCurrentLessonSentence();
    await _cacheGame();
  }

  Future<void> goToNextSentence() async{
    clickedWordsForCurrentSentence.clear();
    _sentenceNumber = _sentenceNumber + 1;
    _setCurrentLessonSentence();
    await _cacheGame();
  }

  Set<EnglishRussianSentence> _wrongSentences = Set();
  int get wrongSentencesCount => _wrongSentences.length;
  bool _onMatchSentence(List<String> englishWords){
    final forSentence = _currentSentence;
    if(forSentence == null){
      return false;
    }
    final bool isCorrectMatch = forSentence.isCorrectEnglish(englishWords);
    if(!isCorrectMatch){
      _wrongSentences.add(forSentence);
    }
    return isCorrectMatch;
  }

  /// use list because we need to track the order of clicked words
  List<String> clickedWordsForCurrentSentence  = [];
  void onClickWordForCurrentSentence(String word) {
    clickedWordsForCurrentSentence.add(word);
  }
  SentenceMatchingResult checkIfSentenceIsMatched() {
        final bool allWordsUsed  = englishWordsToMatch.length == clickedWordsForCurrentSentence.length;
        if(!allWordsUsed)
          return SentenceMatchingResult.waiting; // wait until all words have been used
        final bool isMatched =  _onMatchSentence(clickedWordsForCurrentSentence);
        return
          isMatched  ?
            SentenceMatchingResult.matchedCorrectly
              : SentenceMatchingResult.matchedWrong;
  }

  void onRetrySentence(){
    clickedWordsForCurrentSentence.clear();
  }

  void disposeStateData() {
    reachedEndOfGame = false;
    reachedEndOfLesson = false;
    currentLesson = {};
    _currentSentence = null;
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
