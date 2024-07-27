import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/state/match_russian_to_english_state.dart';
import 'package:hi_bob/features/games/presentation/widgets/game_loading.dart';
import 'package:hi_bob/features/games/presentation/widgets/game_results.dart';
import 'package:hi_bob/features/games/presentation/widgets/get_started.dart';
import 'package:hi_bob/features/games/presentation/widgets/word_card.dart';

class MatchingWordsGameScreen extends StatefulWidget {
  const MatchingWordsGameScreen({super.key});

  @override
  State<MatchingWordsGameScreen> createState() =>
      _MatchingWordsGameScreenState();
}

class _MatchingWordsGameScreenState extends State<MatchingWordsGameScreen> {
  String? _wordAwaitingMatching;
  Timer? _timer;
  int _totalTimeTakenInSeconds = 0;
  GameStates _gameStates = GameStates.init;


  @override
  void initState() {
    super.initState();
    // init state
    RussianEnglishStateController();
  }

  RussianEnglishStateController get _state =>
      RussianEnglishStateController.instance;


  void _startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (t.isActive && mounted) {
          _totalTimeTakenInSeconds = _totalTimeTakenInSeconds + 1;
      }
    });
  }

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
          onStartLesson: (int lessonNumber) => _initializePlay(
              lessonNumber:lessonNumber,
          ),
          onResume: _initializePlay,
        );
      case GameStates.play:
        return SafeFullScreenContainer(
          padding: EdgeInsets.all(16),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: TopLeftColumn(
              _state.russianToShuffledEnglish.entries
                  .map(
                    (ruToEng) => SpaceBtnCenterRow([
                      _buildWordCard(
                        wordTagSuffix: '_${ruToEng.key}',
                        word: ruToEng.key,
                        isRussian: true,
                      ),
                      _buildWordCard(
                        wordTagSuffix: '_${ruToEng.key}',
                        word: ruToEng.value,
                        isRussian: false,
                      ),
                    ]),
                  )
                  .toList(),
            ),
          ),
        );
      case GameStates.done:
        /// TODO make the wording match the actual data  incorrectTimes vs  correctTimes
        return GameResults(
          gotWrongText: context.translated.wrongAttempts(_state.incorrectTimes),
          allText: context.translated.totalWords(_state.correctTimes),
          totalTimeLabel:
          context.translated.timeTaken(Duration(seconds: _totalTimeTakenInSeconds).inMinutes),
          onDone: () {
            context.goHome();
          },
        );
      case GameStates.loading:
        return GameLoading();
    }
  }

  Widget _buildWordCard({
    required String word,
    required bool isRussian,
    required String wordTagSuffix,
  }) {
    final tag = _state.getWordTag(word,wordTagSuffix);
    return WordCard(
      word: word,
      onTap: () {
        final matchStatus = isRussian
            ? _state.onClickedRussianWord(word, wordTagSuffix)
            : _state.onClickedEnglishWord(word, wordTagSuffix);
        _checkMatchStatus(
          matchStatus,
          justClicked: word,
        );
      },
      highlightAsClicked: word == _wordAwaitingMatching,
      highlightAsMatched: isRussian
          ? _state.matchedRussianWords.contains(tag)
          : _state.matchedEnglishWords.contains(tag),
    );
  }


  Future<void> _initializePlay({int? lessonNumber }) async {
      setState(() {
        _gameStates = GameStates.loading;
        _state.disposeStateData();
        _resetState();
      });
      await _state.initialize(
          lessonNumber  : lessonNumber,
      );
      setState(() {
        _gameStates = GameStates.play;
      });
      _startTimer();
    }


  void _checkMatchStatus(
      MatchStateOnClick matchStatus, {
        required String justClicked,
      }) {
    switch (matchStatus) {
      case MatchStateOnClick.awaitNextClick:
        setState(() {
          _wordAwaitingMatching = justClicked;
        });

      case MatchStateOnClick.matched:
        setState(() {
          _wordAwaitingMatching = null;
        });
        if (_state.allWordsInPageMatched) {
          _goToNextPage();
        }
      case MatchStateOnClick.mismatched:
        setState(() {
          _wordAwaitingMatching = null;
        });
        context.showErrorSnack('Wrong!');
        context.removeSnack();
    }

  }

  Future<void> _goToNextPage() async {
    context.showSuccessSnack('Awesome!');
    setState(() {
      _gameStates = GameStates.loading;
    });
    await Future.delayed(Duration(seconds: 1), () {});
    _wordAwaitingMatching = null;
    await _state.toNextPage();
    if (_state.endOfGame) {
      setState(() {
        _gameStates = GameStates.done;
      });
      _timer?.cancel();
    }else{
      setState(() {
        _gameStates = GameStates.play;
      });
    }
  }

  @override
  void dispose() {
    _gameStates = GameStates.init;
    _timer?.cancel();
    _resetState();
    super.dispose();
  }
  void _resetState(){
    _totalTimeTakenInSeconds = 0;
    _wordAwaitingMatching = null;
  }
}

enum GameStates {
  init,
  loading,
  play,
  done;

  bool get isDone => this == GameStates.done;
}
