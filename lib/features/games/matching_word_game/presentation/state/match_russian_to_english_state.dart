import 'package:basics/basics.dart';
import 'package:hi_bob/features/games/data/local/english_russian_words.dart';

class RussianEnglishStateController {
  static RussianEnglishStateController? _instance;
  factory RussianEnglishStateController() {
    _instance ??= RussianEnglishStateController._internal();
    return _instance!;
  }

  RussianEnglishStateController._internal();

  static RussianEnglishStateController get instance => _instance!;

  final _allRussianToEnglish = getRussianToEnglishMatches();
  int _pageNumber = 1;
  final int _entriesPerPage = 7;

  final Map<String, List<String>> _currentRussianToEnglishBatch = {};
  final Map<String, String> currentRussianToShuffledEnglishBatch = {};
  void initializeBatch() {
    _setCurrentWordsBatch();
    _setCurrentRussianToShuffledEnglishBatch();
  }

  void _setCurrentWordsBatch() {
    _currentRussianToEnglishBatch.clear();
    int startIndex = (_pageNumber - 1) * _entriesPerPage;
    if (startIndex < 0) {
      startIndex = 0;
    }
    int endIndex = startIndex + _entriesPerPage;

    List<MapEntry<String, List<String>>> entries =
        _allRussianToEnglish.entries.toList();

    if (startIndex >= entries.length) {
      return;
    }

    if (endIndex > entries.length) {
      endIndex = entries.length;
    }
    entries.sublist(startIndex, endIndex).forEach((entry) {
      _currentRussianToEnglishBatch[entry.key] = entry.value;
    });
  }

  List<String> get _engWordsInCurrentBatch =>
      _currentRussianToEnglishBatch.values
          .map(
            (russianToEnglish) => russianToEnglish.getRandom() ?? '',
          )
          .toList();
  List<String> get _russianWordsInCurrentBatch =>
      _currentRussianToEnglishBatch.keys.toList();

  void _setCurrentRussianToShuffledEnglishBatch() {
    currentRussianToShuffledEnglishBatch.clear();
    final shuffledEnglishWords = <String>[];
    shuffledEnglishWords.addAll(_engWordsInCurrentBatch);
    shuffledEnglishWords.shuffle();
    for (int i = 0; i < _engWordsInCurrentBatch.length; i++) {
      final eng = shuffledEnglishWords[i];
      final rus = _russianWordsInCurrentBatch[i];
      currentRussianToShuffledEnglishBatch[rus] = eng;
    }
  }

  String? _clickedRussianWord;
  String? _clickedEnglishWord;

  MatchStateOnClick onClickedRussianWord(String clickedRussianWord) {
    _clickedRussianWord = clickedRussianWord;
    return _checkIfMatchedCorrectly();
  }

  MatchStateOnClick onClickedEnglishWord(String clickedEnglishWord) {
    _clickedEnglishWord = clickedEnglishWord;
    return _checkIfMatchedCorrectly();
  }

  MatchStateOnClick _checkIfMatchedCorrectly() {
    bool checkIfMatching =
        _clickedEnglishWord != null && _clickedRussianWord != null;
    if (!checkIfMatching) {
      return MatchStateOnClick.awaitNextClick;
    }

    final bool? match = _currentRussianToEnglishBatch[_clickedRussianWord!]
        ?.contains(_clickedEnglishWord);
    final bool matched = match == true;
    _setMatchedWords(matched: matched);
    _setMisMatchedWords(matched: matched);
    _resetAfterMatchAttempt(matched: matched);
    return matched ? MatchStateOnClick.matched : MatchStateOnClick.mismatched;
  }

  final Set<String> currentBatchMatched = Set();
  void _resetAfterMatchAttempt({required bool matched}) {
    _clickedRussianWord = null;
    _clickedEnglishWord = null;
  }
  void _setMatchedWords({required bool matched}) {
    if (!matched) {
      return;
    }
    currentBatchMatched.add(_clickedRussianWord!);
    currentBatchMatched.add(_clickedEnglishWord!);
  }
  
  bool  get allWordsMatched  => currentBatchMatched.length  == (currentRussianToShuffledEnglishBatch.length * 2); 

  final Set<String> _wordsGotWrong = Set();
  void _setMisMatchedWords({required bool matched}) {
    if(matched) {
      return;
    }
    _wordsGotWrong.add(_clickedRussianWord!);
    _wordsGotWrong.add(_clickedEnglishWord!);
  }

  void toNextPage() {
    _pageNumber++;
    currentBatchMatched.clear();
    currentRussianToShuffledEnglishBatch.clear();
    _currentRussianToEnglishBatch.clear();
    initializeBatch();
  }

}

enum MatchStateOnClick {
  awaitNextClick,
  matched,
  mismatched;
}
