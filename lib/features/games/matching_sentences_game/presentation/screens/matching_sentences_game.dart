import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/presentation/widgets/game_loading.dart';

class MatchingSentencesGameScreen extends StatefulWidget {
  const MatchingSentencesGameScreen({super.key});

  @override
  State<MatchingSentencesGameScreen> createState() => _MatchingSentencesGameScreenState();
}

class _MatchingSentencesGameScreenState extends State<MatchingSentencesGameScreen> {
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
      body: GameLoading(),
    );
  }
}
