import 'package:hi_bob/features/games/data/local/english_russian_words.dart';
import 'package:hi_bob/features/games/domain/keys/matching_words_keys.dart';
import 'package:hi_bob/features/services/local_storage.dart';

int maxWordsPerPage = 5;

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

  int _lessonNumber = 1;
  int _pageNumber = 1;
  bool endOfGame = false;

  Future<void> initialize({
    int? lessonNumber,
  }) async {
    final bool resume = lessonNumber == null;
    if (resume) {
      _lessonNumber = await _localStorage
              .getInt(MatchingWordsKeys.lessonNumberStorageKey.key) ??
          1;
      _pageNumber = await _localStorage
              .getInt(MatchingWordsKeys.pageNumberStorageKey.key) ??
          1;
    }
    if (!resume) {
      _lessonNumber = lessonNumber;
      _pageNumber = 1;
    }
    await _localStorage.setInt(
      MatchingWordsKeys.lessonNumberStorageKey.key,
      _lessonNumber,
    );

    await _localStorage.setInt(
      MatchingWordsKeys.pageNumberStorageKey.key,
      _pageNumber,
    );
    await _loadLessonWords();
  }

  Map<int, Map<String, String>> _correctRussianToEnglishWordsPerPage = {};
  Map<String, String> _correctWordsInCurrentPage = {};

  Future<void> _loadLessonWords() async {
    _correctRussianToEnglishWordsPerPage.clear();
    final correctRussianToEnglishWords = await getLessonWordsRussianToEnglish(
      _lessonNumber,
    );
    int page = 1;
    Map<String, String> pageWords = {};
    for (var entry in correctRussianToEnglishWords.entries) {
      pageWords[entry.key] = entry.value;
      if (pageWords.length == maxWordsPerPage) {
        _correctRussianToEnglishWordsPerPage[page] = {}..addAll(pageWords);
        pageWords.clear();
        page++;
      }
    }
    await _loadCurrentPageWords();
  }

  void _setRussianToShuffledEnglish() {
    russianToShuffledEnglish.clear();
    final russian = _correctWordsInCurrentPage.keys.toList();
    final english = _correctWordsInCurrentPage.values.toList();
    english.shuffle();
    final Map<String, String> words = {};
    int i = 0;
    for (var r in russian) {
      words[r] = english[i];
      i++;
    }
    russianToShuffledEnglish.addAll(words);
  }

  Map<String, String> russianToShuffledEnglish = {};
  Future<void> _loadCurrentPageWords() async{
    endOfGame = !_correctRussianToEnglishWordsPerPage.containsKey(_pageNumber);
    if (endOfGame) {
      await _localStorage.addToIntList(
        MatchingWordsKeys.completedLessonsListKey.key,
        _lessonNumber,
      );
      return;
    }
    _correctWordsInCurrentPage.clear();
    _correctWordsInCurrentPage.addAll(
      _correctRussianToEnglishWordsPerPage[_pageNumber]!,
    );
    _setRussianToShuffledEnglish();
  }

  bool allWordsInPageMatched = false;
  String? _lastClickedRussianWord;
  String? _lastClickedEnglishWord;
  int incorrectTimes = 0;
  int correctTimes = 0;
  Set<String> _matchedRussianWords = Set();
  Set<String> _matchedEnglishWords = Set();

  Set<String> get matchedRussianWords => _matchedRussianWords;
  Set<String> get matchedEnglishWords => _matchedEnglishWords;

  int _correctTimesPerPage = 0;
  MatchStateOnClick onClickedRussianWord(String word, String wordTagSuffix) {
    final lastEnglish = _lastClickedEnglishWord;
    if (lastEnglish == null) {
      _lastClickedRussianWord = word;
      return MatchStateOnClick.awaitNextClick;
    }

    final correctEnglish = _correctWordsInCurrentPage[word];
    if (correctEnglish == lastEnglish) {
      _lastClickedRussianWord = null;
      _lastClickedEnglishWord = null;
      correctTimes++;
      _correctTimesPerPage++;
      allWordsInPageMatched =
          _correctTimesPerPage == _correctWordsInCurrentPage.length;
      _addToMatchedRussian(getWordTag(word, wordTagSuffix));
      _addToMatchedEnglish(getWordTag(lastEnglish, wordTagSuffix));
      return MatchStateOnClick.matched;
    } else {
      incorrectTimes++;
      return MatchStateOnClick.mismatched;
    }
  }

  String getWordTag(String word, String tag) => '$word$tag';

  MatchStateOnClick onClickedEnglishWord(String word, String wordTagSuffix) {
    final lastRussian = _lastClickedRussianWord;
    if (lastRussian == null) {
      _lastClickedEnglishWord = word;
      return MatchStateOnClick.awaitNextClick;
    }

    final correctEnglish = _correctWordsInCurrentPage[lastRussian];
    if (correctEnglish == word) {
      _lastClickedRussianWord = null;
      _lastClickedEnglishWord = null;
      correctTimes++;
      _correctTimesPerPage++;
      allWordsInPageMatched =
          _correctTimesPerPage == _correctWordsInCurrentPage.length;
      _addToMatchedEnglish(getWordTag(word, wordTagSuffix));
      _addToMatchedRussian(getWordTag(lastRussian, wordTagSuffix));
      return MatchStateOnClick.matched;
    } else {
      incorrectTimes++;
      return MatchStateOnClick.mismatched;
    }
  }

  Future<void> toNextPage() async {
    _pageNumber++;
    _correctTimesPerPage = 0;
    await _localStorage.setInt(
      MatchingWordsKeys.pageNumberStorageKey.key,
      _pageNumber,
    );
    await _loadCurrentPageWords();
  }

  void disposeStateData() {
    _correctTimesPerPage = 0;
    _lessonNumber = 1;
    _pageNumber = 1;
    endOfGame = false;
    _lastClickedRussianWord = null;
    _lastClickedEnglishWord = null;
    incorrectTimes = 0;
    correctTimes = 0;
    allWordsInPageMatched = false;
  }

  void _addToMatchedRussian(String wordTag) {
    final Set<String> tmp = Set();
    tmp.addAll(_matchedRussianWords);
    tmp.add(wordTag);
    _matchedRussianWords = tmp;
  }

  void _addToMatchedEnglish(String wordTag) {
    final Set<String> tmp = Set();
    tmp.addAll(_matchedEnglishWords);
    tmp.add(wordTag);
    _matchedEnglishWords = tmp;
  }
}

enum MatchStateOnClick {
  awaitNextClick,
  matched,
  mismatched,
}
