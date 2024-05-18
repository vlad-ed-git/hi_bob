import 'package:basics/basics.dart';
import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/data/local/english_russian_words.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/state/match_russian_to_english_state.dart';
import 'package:hi_bob/features/games/presentation/widgets/word_card.dart';

class MatchingWordsGameScreen extends StatefulWidget {
  const MatchingWordsGameScreen({super.key});

  @override
  State<MatchingWordsGameScreen> createState() =>
      _MatchingWordsGameScreenState();
}

class _MatchingWordsGameScreenState extends State<MatchingWordsGameScreen> {
  String? _wordAwaitingMatching;
  Set<String> _matchedWords = Set();

  @override
  void initState() {
    super.initState();
    // init state
    RussianEnglishStateController();
    _state.initializeBatch();
  }

  RussianEnglishStateController get _state =>
      RussianEnglishStateController.instance;

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
      body: SafeFullScreenContainer(
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
      ),
    );
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
      matched: _matchedWords.contains(word),
    );
  }

  void _checkMatchStatus(
    MatchStateOnClick matchStatus, {
    required String justClicked,
  }) {
    setState(() {
      switch (matchStatus) {
        case MatchStateOnClick.awaitNextClick:
          _wordAwaitingMatching = justClicked;
        case MatchStateOnClick.matched:
          _wordAwaitingMatching = null;
          _matchedWords = _state.currentBatchMatched;
          if(_state.allWordsMatched) {
            _goToNextPage();
          }
        case MatchStateOnClick.mismatched:
          _wordAwaitingMatching = null;
          context.showErrorSnack('Wrong!');
          context.removeSnack();
      }
    });
  }

  Future<void> _goToNextPage() async{
    context.showSuccessSnack('Awesome!');
    await Future.delayed(Duration(seconds: 1), (){});
    _state.toNextPage();
    setState(() {

    });
  }
}
