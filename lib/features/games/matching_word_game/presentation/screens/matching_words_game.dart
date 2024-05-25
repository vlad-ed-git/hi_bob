import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/state/match_russian_to_english_state.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/widgets/game_loading.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/widgets/game_results.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/widgets/get_started.dart';
import 'package:hi_bob/features/games/presentation/widgets/word_card.dart';

class MatchingWordsGameScreen extends StatefulWidget {
  const MatchingWordsGameScreen({super.key});

  @override
  State<MatchingWordsGameScreen> createState() =>
      _MatchingWordsGameScreenState();
}

class _MatchingWordsGameScreenState extends State<MatchingWordsGameScreen> {
  String? _wordAwaitingMatching;
  late Timer _timer;
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.isActive && mounted) {
        setState(() {
          _totalTimeTakenInSeconds = _totalTimeTakenInSeconds + 1;
        });
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
          onStartNormal: _initializePlay,
          onStartEasy: () => _initializePlay(
            easy:true,
          ),
          onResume: () => _initializePlay(
       resume:true,
    ),);
      case GameStates.play:
        return SafeFullScreenContainer(
          padding: EdgeInsets.all(16),
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: TopLeftColumn(
              _state.currentRussianToShuffledEnglishBatch.entries
                  .map(
                    (ruToEng) => SpaceBtnCenterRow([
                      _buildWordCard(
                        word: ruToEng.key,
                        isRussian: true,
                      ),
                      _buildWordCard(
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
        return GameResults(
          wordsGotWrong: _state.wordsGotWrongCount,
          allWords: _state.totalWordsCount,
          totalTimeTakenInSeconds: _totalTimeTakenInSeconds,
          onDone: () {
            _totalTimeTakenInSeconds = 0;
            _timer.cancel();
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
  }) {
    return WordCard(
      word: word,
      onTap: () {
        final matchStatus = isRussian
            ? _state.onClickedRussianWord(word)
            : _state.onClickedEnglishWord(word);
        _checkMatchStatus(
          matchStatus,
          justClicked: word,
        );
      },
      clicked: word == _wordAwaitingMatching,
      matched: isRussian
          ? _state.matchedRussianWords.contains(word)
          : _state.matchedEnglishWords.contains(word),
    );
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
        if (_state.allWordsMatched) {
          _goToNextBatch();
        }
      case MatchStateOnClick.mismatched:
       setState(() {
         _wordAwaitingMatching = null;
       });
       context.showErrorSnack('Wrong!');
       context.removeSnack();
    }

  }

  Future<void> _goToNextBatch() async {
    context.showSuccessSnack('Awesome!');
    setState(() {
      _gameStates = GameStates.loading;
    });
    await Future.delayed(Duration(seconds: 1), () {});
    _wordAwaitingMatching = null;
    await _state.toNextBatch();
    if (_state.endOfGame) {
      setState(() {
        _gameStates = GameStates.done;
      });
      _timer.cancel();
    }else{
      setState(() {
        _gameStates = GameStates.play;
      });
    }
  }

  @override
  void dispose() {
    _gameStates = GameStates.init;
    _timer.cancel();
    _disposeState();
    super.dispose();
  }
  void _disposeState(){
    _totalTimeTakenInSeconds = 0;
    _wordAwaitingMatching = null;
  }

  Future<void> _initializePlay({bool resume = false, bool easy = false,}) async {
      setState(() {
        _gameStates = GameStates.loading;
        _state.disposeStateData();
        _disposeState();
      });
      await _state.initialize(
        shuffle: !easy,
        resume:resume,
      );
      setState(() {
        _gameStates = GameStates.play;
      });
      _startTimer();
    }
}

enum GameStates {
  init,
  loading,
  play,
  done;

  bool get isDone => this == GameStates.done;
}
