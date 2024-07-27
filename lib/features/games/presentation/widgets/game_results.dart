import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/assets/app_images.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class GameResults extends StatelessWidget {
  final String gotWrongText;
  final String allText;
  final String totalTimeLabel;
  final VoidCallback onDone;
  const GameResults({
    super.key,
    required this.gotWrongText,
    required this.allText,
    required this.totalTimeLabel,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return SafeFullScreenContainer(
      padding: EdgeInsets.all(16),
      CenterColumn(
        [
          Image.asset(
            AppImages.mascotResult.assetPath,
            height: 96,
          ),
          const SizedBox(
            height: 8,
          ),
          H5(
            context.translated.congrats,
            txtAlign: TextAlign.center,
            color: context.color.primary,
          ),
          const SizedBox(
            height: 8,
          ),
          P1(
            allText,
            txtAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          P1(
            totalTimeLabel,
            txtAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          P1(
            gotWrongText,
            txtAlign: TextAlign.center,
            color: context.color.error,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
