import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class GameResults extends StatelessWidget {
  final  int wordsGotWrong;
  final  int allWords;
  final  int totalTimeTakenInSeconds;
  final  VoidCallback onDone;
  const GameResults({
    super.key,
    required this.wordsGotWrong,
    required this.allWords,
    required this.totalTimeTakenInSeconds,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return SafeFullScreenContainer(
      padding: EdgeInsets.all(16),
      CenterColumn(
         [
          H5(
            context.translated.congrats,
            txtAlign: TextAlign.center,
            color: context.color.primary,
          ),
          const SizedBox(height: 8,),
           P1(
             context.translated.totalWords(allWords),
             txtAlign: TextAlign.center,
           ),
           const SizedBox(height: 8,),
           P1(
             context.translated.timeTaken(Duration(seconds: totalTimeTakenInSeconds).inMinutes),
             txtAlign: TextAlign.center,
           ),
           const SizedBox(height: 8,),
           P1(
             context.translated.wrongAttempts(wordsGotWrong),
             txtAlign: TextAlign.center,
             color: context.color.error,
           ),
           const SizedBox(height: 8,),
        ],
      ),
    );
  }
}
