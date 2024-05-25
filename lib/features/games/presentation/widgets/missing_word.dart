import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/matching_sentences_game/presentation/state/match_russian_to_english_state_sentences.dart';
import 'package:hi_bob/features/games/presentation/widgets/game_loading.dart';
import 'package:hi_bob/features/games/presentation/widgets/get_started.dart';


class MissingWord extends StatelessWidget {
  final String expectedWord;
  final bool highlightAsError;
  const MissingWord({super.key, required this.expectedWord, required this.highlightAsError,});

  @override
  Widget build(BuildContext context) {
    final color  = Color(0xFFE5E5E5);
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 8,),
      height: 56,
      width: expectedWord.length*24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: highlightAsError ? Border.all(
          color : context.color.error,
        ) : null,
      ),
    );
  }
}
