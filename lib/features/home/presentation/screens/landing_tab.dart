import 'package:flutter/material.dart';
import 'package:hi_bob/core/routing/domain/navigation.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class LandingTabScreen extends StatelessWidget {
  const LandingTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.primary,
        title: Subtitle1(
          context.translated.homeTabAppBarTitle,
          color: context.color.onPrimary,
        ),
        centerTitle: false,
      ),
      body: SafeFullScreenContainer(
        padding: EdgeInsets.all(
          16,
        ),
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: WrapHorizontally(
            Lessons.values
                .map(
                  (lesson) => LessonCard(
                    lessonTitle: lesson.label(context),
                    onClick: () => _onLessonClicked(context, lesson),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _onLessonClicked(BuildContext context, Lessons lesson) {
    switch (lesson) {
      case Lessons.one:
        context.toLessonOne();
      case Lessons.two:
        context.toLessonTwo();
    }
  }
}

enum Lessons {
  one,
  two,;

  String label(BuildContext context) {
    switch (this) {
      case Lessons.one:
        return context.translated.lesson1Title;
      case Lessons.two:
        return context.translated.lesson2Title;
    }
  }
}

class LessonCard extends StatelessWidget {
  final String lessonTitle;
  final VoidCallback onClick;
  const LessonCard({
    super.key,
    required this.lessonTitle,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 240,
        width: context.screenWidth * 0.45,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black12,
          ),
        ),
        alignment: Alignment.center,
        child: P1(
          lessonTitle,
            isTruncated : false,
           txtAlign: TextAlign.center,
        ),
      ),
    );
  }
}
