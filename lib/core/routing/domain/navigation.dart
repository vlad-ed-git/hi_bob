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

  void toLessonOne(){

  }

  void toLessonTwo(){

  }

  void toLessonThree(){

  }
}
