import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/buttons/main_button_outlined.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class GetStarted extends StatelessWidget {
  final VoidCallback onResume;
  final void Function(int number) onStartLesson;
  const GetStarted({
    super.key,
    required this.onResume, required this.onStartLesson,
  });

  @override
  Widget build(BuildContext context) {
    return SafeFullScreenContainer(
      padding: EdgeInsets.all(16),
      CenterLeftColumn(
        [
          H5(
            context.translated.getStartedTitle,
            txtAlign: TextAlign.center,
            color: context.color.primary,
          ),
          const SizedBox(
            height: 16,
          ),
          Flexible(
            child:  ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child:  Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(50, (int index) => index  + 1 ).map(
                          (int number) =>  MainBtnOutline(
                        onClick: (){
                          onStartLesson(number);
                        },
                        child: BtnText(
                          context.translated.lessonNumber(number),
                          txtAlign: TextAlign.center,
                          color: context.color.primary,
                        ),
                      )
                  ).toList(growable: false),
                ),
              ),
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
