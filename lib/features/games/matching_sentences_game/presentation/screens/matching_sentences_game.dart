import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/assets/app_images.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/matching_sentences_game/presentation/state/match_russian_to_english_state_sentences.dart';
import 'package:hi_bob/features/games/presentation/widgets/game_loading.dart';
import 'package:hi_bob/features/games/presentation/widgets/game_results.dart';
import 'package:hi_bob/features/games/presentation/widgets/get_started.dart';
import 'package:hi_bob/features/games/presentation/widgets/missing_word.dart';
import 'package:hi_bob/features/games/presentation/widgets/word_card.dart';

class MatchingSentencesGameScreen extends StatefulWidget {
  const MatchingSentencesGameScreen({super.key});

  @override
  State<MatchingSentencesGameScreen> createState() =>
      _MatchingSentencesGameScreenState();
}

class _MatchingSentencesGameScreenState
    extends State<MatchingSentencesGameScreen> {
  Timer? _timer;
  int _totalTimeTakenInSeconds = 0;
  GameStates _gameStates = GameStates.init;
  bool _showSuccess  = false;
  bool _showRetryCurrentSentence = false;

  @override
  void initState() {
    super.initState();
    // init state
    RussianEnglishSentencesStateController();
  }

  RussianEnglishSentencesStateController get _state =>
      RussianEnglishSentencesStateController.instance;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.isActive && mounted) {
        _totalTimeTakenInSeconds = _totalTimeTakenInSeconds + 1;
      }
    });
  }

  String get _progressLabel => _state.currentSentenceNumberForDisplay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.goBack(),
          icon: Icon(
            Icons.chevron_left,
            color: context.color.onPrimary,
            size: 32,
          ),
        ),
        backgroundColor: context.color.primary,
        title: Subtitle1(
          context.translated.lesson1Title,
          color: context.color.onPrimary,
        ),
        centerTitle: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_gameStates) {
      case GameStates.init:
        return GetStarted(
            onResume: _initializePlay,
            onStartLesson: (int number) {
              _initializePlay(lessonNumber : number);
            },
            );
      case GameStates.loading:
        return GameLoading();
      case GameStates.play:
        return SafeFullScreenContainer(
          padding: EdgeInsets.all(16),
          TopLeftColumn([
            HintText(
              _progressLabel
            ),
            SizedBox(
              height: 12,
            ),
            H6(
              _state.russianSentence,
              isTruncated: false,
            ),
            SizedBox(
              height: 8,
            ),
            Flexible(
              child: WrapHorizontally(
                _getMatchedOrFilledWords(),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Image.asset(
                 _showSuccess ?
                     AppImages.mascotHappy.assetPath :
                  _showRetryCurrentSentence?
                      AppImages.mascotCry.assetPath :
                AppImages.mascotTeach.assetPath,
                height: 100,
              ),
            ),
            Expanded(child: SizedBox.shrink()),
            Flexible(
              child: WrapHorizontally(
                _state.englishWordsToMatch
                    .map(
                      (word) => WordCard(
                        word: word,
                        onTap: () {
                          _state.clickedWordsForCurrentSentence.add(word);
                          setState(() {}); // refresh to show clicked words

                          final SentenceMatchingResult result =
                          _state.checkIfSentenceIsMatched();
                          switch (result) {
                            case SentenceMatchingResult.waiting:
                              return;
                            case SentenceMatchingResult.matchedWrong:
                              setState(() {
                                _showRetryCurrentSentence = true;
                              });
                            case SentenceMatchingResult.matchedCorrectly:
                              _onSuccessfullyCompletedSentence();
                          }
                        },
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            if(_showRetryCurrentSentence)
            IconButton(
              onPressed: () {
                _state.clickedWordsForCurrentSentence.clear();
                setState(() {
                  _showRetryCurrentSentence = false;
                }); // refresh
              },
              icon: Icon(
                Icons.refresh,
                size: 32,
                color: context.color.error,
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ]),
        );
      case GameStates.done:
        return GameResults(
          gotWrongText: context.translated.wrongAttempts(_state.wrongSentencesCount),
          allText: context.translated.progress(_progressLabel),
          totalTimeLabel:
          context.translated.timeTaken(Duration(seconds: _totalTimeTakenInSeconds).inMinutes),
          onDone: () {
            context.goHome();
          },
        );
    }
  }

  Future<void> _onSuccessfullyCompletedSentence() async {
    setState(() {
      _gameStates = GameStates.loading;
      _showSuccess = true;
    });
    context.showSuccessSnack('Awesome!');
    await Future.delayed(Duration(seconds: 1), () {});
    setState(() {
      _showSuccess = false;
    });
    await _state.moveToNextSentence();
    if (_state.reachedEndOfLesson) {
      setState(() {
        _gameStates = GameStates.done;
      });
      return;
    }
    setState(() {
      _gameStates = GameStates.play;
    }); // refresh
  }

  List<Widget> _getMatchedOrFilledWords() {
    /// displays a row of blank / filled words
    final allEnglishWords = _state.englishWordsToMatch;
    final maxWords = allEnglishWords.length;
    List<Widget> matchedOrFilledWordContainers = [];
    int takenWordSpace = 0;
    for (var word in _state.clickedWordsForCurrentSentence) {
      if (matchedOrFilledWordContainers.length < maxWords) {
        /// add the clicked word in order of what has been clicked
        matchedOrFilledWordContainers.add(
          WordCard(
              highlightAsError : _showRetryCurrentSentence,
              word: word,),
        );
        takenWordSpace++;
      }
    }

    while (takenWordSpace < maxWords) {
      /// add blank space
      final word = allEnglishWords[takenWordSpace];
      matchedOrFilledWordContainers.add(
        MissingWord(
          highlightAsError : _showRetryCurrentSentence,
          expectedWord: word,
        ),
      );
      takenWordSpace++;
    }
    return matchedOrFilledWordContainers;
  }

  Future<void> _initializePlay({
     int? lessonNumber,
  }) async {
    setState(() {
      _gameStates = GameStates.loading;
      _state.disposeStateData();
      _resetState();
    });
    await _state.initialize(
        lessonNumber:lessonNumber,
    );
    setState(() {
      _gameStates = GameStates.play;
    });
    _startTimer();
  }

  @override
  void dispose() {
    _gameStates = GameStates.init;
    _timer?.cancel();
    _resetState();
    super.dispose();
  }

  void _resetState() {
    _totalTimeTakenInSeconds = 0;
    _state.disposeStateData();
  }
}

enum GameStates {
  init,
  loading,
  play,
  done;

  bool get isDone => this == GameStates.done;
}
