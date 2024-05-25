import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/buttons/main_button_outlined.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class GetStarted extends StatelessWidget {
  final VoidCallback onStartNormal, onStartEasy, onResume;
  const GetStarted({
    super.key,
    required this.onStartNormal,
    required this.onStartEasy,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    return SafeFullScreenContainer(
      padding: EdgeInsets.all(16),
      CenterColumn(
        [
          H5(
            context.translated.getStartedTitle,
            txtAlign: TextAlign.center,
            color: context.color.primary,
          ),
          const SizedBox(
            height: 16,
          ),
          MainBtnOutline(
            onClick: onStartEasy,
            child: BtnText(
              context.translated.startEasyMode,
              txtAlign: TextAlign.center,
              color: context.color.primary,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          MainBtnOutline(
            onClick: onStartNormal,
            borderColor: context.color.secondary,
            child: BtnText(
              context.translated.startNormalMode,
              txtAlign: TextAlign.center,
              color: context.color.secondary,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          MainBtnOutline(
            onClick: onResume,
            borderColor: context.color.tertiary,
            child: BtnText(
              context.translated.resume.toUpperCase(),
              txtAlign: TextAlign.center,
              color: context.color.tertiary,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
