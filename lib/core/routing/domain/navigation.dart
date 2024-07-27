import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_bob/core/routing/domain/home_page_routes.dart';

extension AppNavigation on BuildContext {
  void goBack() {
    pop();
  }

  void goHome() {
    go(HomePageRoutes.main.path);
  }

  String get lessonOneRoutePath =>
      '${HomePageRoutes.main.path}/${HomePageRoutes.matchingWordsGame.path}';

  String get lessonTwoRoutePath =>
      '${HomePageRoutes.main.path}/${HomePageRoutes.matchingSentencesGame.path}';

  Future<dynamic> toLessonOne() async{
      return push(lessonOneRoutePath);
  }

  Future<dynamic> toLessonTwo() async{
    return push(lessonTwoRoutePath);
  }

}
