import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/buttons/main_button_outlined.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
import 'package:hi_bob/features/games/domain/keys/matching_words_keys.dart';
import 'package:hi_bob/features/services/local_storage.dart';

class GetStarted extends StatelessWidget {
  final VoidCallback onResume;
  final void Function(int number) onStartLesson;
  final Future<List<int>> Function() getCompletedLessons;
  const GetStarted({
    super.key,
    required this.onResume, required this.onStartLesson, required this.getCompletedLessons,
  });

  @override
  Widget build(BuildContext context) {
    return SafeFullScreenContainer(
      padding: EdgeInsets.all(16),
      FutureBuilder<List<int>>(
        future: getCompletedLessons(),
        builder: (context, snapshot) {
          final List<int> completedLessons = snapshot.data ?? [];
          return CenterLeftColumn(
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
                              (int number){
                                final bool isCompleted = completedLessons.contains(number);
                                return MainBtnOutline(
                                  onClick: (){
                                    onStartLesson(number);
                                  },
                                  borderColor: isCompleted ? context.color.primary
                                  : Colors.grey,
                                  child: LeftCenteredInRow(
                                    [
                                      Icon(
                                          isCompleted ? Icons.check_circle_outline_rounded
                                              : Icons.radio_button_unchecked_outlined,
                                        color: isCompleted ? context.color.primary
                                         : Colors.grey,
                                      ),
                                      SizedBox(width: 12,),
                                      BtnText(
                                        context.translated.lessonNumber(number),
                                        txtAlign: TextAlign.center,
                                        color: context.color.primary,
                                      ),
                                    ],
                                  ),
                                );
                              }
                      ).toList(growable: false),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          );
        },
      ),
    );
  }


}
