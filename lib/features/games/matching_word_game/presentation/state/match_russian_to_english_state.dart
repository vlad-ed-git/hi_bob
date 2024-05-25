import 'package:basics/basics.dart';
import 'package:hi_bob/features/games/data/local/english_russian_words.dart';
import 'package:hi_bob/features/services/local_storage.dart';

const String _gamePageStorageKey = 'lastMatchingWordsPageKey';
const String _lastMatchingWordsIsEasyModeKey = 'lastMatchingWordsIsEasyModeKey';

class RussianEnglishStateController {
  static RussianEnglishStateController? _instance;
  factory RussianEnglishStateController() {
    _instance ??= RussianEnglishStateController._internal();
    LocalStorageServices();
    return _instance!;
  }

  RussianEnglishStateController._internal();

  static RussianEnglishStateController get instance => _instance!;
  static LocalStorageServices get _localStorage =>
      LocalStorageServices.instance;

  final _allRussianToEnglish = getRussianToEnglishMatches();
  int _batchNumber = 1;
  bool endOfGame = false;
  bool _shuffle = true;
  final int _entriesPerPage = 7;

  final Map<String, List<String>> _currentRussianToEnglishBatch = {};
  final Map<String, String> currentRussianToShuffledEnglishBatch = {};
  Future<void> initialize({
    required bool shuffle,
    required bool resume,
  }) async {
    if (resume) {
      _batchNumber = await _localStorage.getInt(_gamePageStorageKey) ?? 1;
      final easyMode = await _localStorage.getBool(_lastMatchingWordsIsEasyModeKey);
      _shuffle = !easyMode;
    }
    if (!resume) {
      _shuffle = shuffle;
    }
    await _localStorage.setInt(
      _gamePageStorageKey,
      _batchNumber,
    );
    await _localStorage.setBool(
      _lastMatchingWordsIsEasyModeKey,
      value: !_shuffle,
    );
    _loadBatchWords();
  }

  void _loadBatchWords() {
    _setCurrentWordsBatch();
    _setCurrentRussianToShuffledEnglishBatch();
  }

  void _setCurrentWordsBatch() {
    _currentRussianToEnglishBatch.clear();
    int startIndex = (_batchNumber - 1) * _entriesPerPage;
    if (startIndex < 0) {
      startIndex = 0;
    }
    int endIndex = startIndex + _entriesPerPage;

    List<MapEntry<String, List<String>>> entries =
        _allRussianToEnglish.entries.toList();

    if (startIndex >= entries.length) {
      endOfGame = true;
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
    if (_shuffle) shuffledEnglishWords.shuffle();
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

  final Set<String> matchedRussianWords = Set();
  final Set<String> matchedEnglishWords = Set();
  void _resetAfterMatchAttempt({required bool matched}) {
    _clickedRussianWord = null;
    _clickedEnglishWord = null;
  }

  void _setMatchedWords({required bool matched}) {
    if (!matched) {
      return;
    }
    matchedRussianWords.add(_clickedRussianWord!);
    matchedEnglishWords.add(_clickedEnglishWord!);
  }

  /// note: many russian words can match onto 1 english word
  /// so there are duplicated english words
  bool get allWordsMatched {
    return matchedEnglishWords.length ==
        currentRussianToShuffledEnglishBatch.values.toSet().length;
  }

  final Set<String> _wordsGotWrong = Set();
  void _setMisMatchedWords({required bool matched}) {
    if (matched) {
      return;
    }
    _wordsGotWrong.add(_clickedRussianWord!);
    _wordsGotWrong.add(_clickedEnglishWord!);
  }

  void disposeStateData() {
    matchedEnglishWords.clear();
    matchedRussianWords.clear();
    currentRussianToShuffledEnglishBatch.clear();
    _currentRussianToEnglishBatch.clear();
  }

  Future<void> toNextBatch() async {
    _batchNumber++;
    disposeStateData();
    _loadBatchWords();
    if (endOfGame) {
      await _localStorage.setInt(
        _gamePageStorageKey,
        1,
      );
      await _localStorage.setBool(
        _lastMatchingWordsIsEasyModeKey,
        value: false,
      );
      return;
    }
    // not end of game
    await _localStorage.setInt(
      _gamePageStorageKey,
      _batchNumber,
    );
  }

  int get wordsGotWrongCount => _wordsGotWrong.length;
  int get totalWordsCount => _allRussianToEnglish.length;
}

enum MatchStateOnClick {
  awaitNextClick,
  matched,
  mismatched;
}
