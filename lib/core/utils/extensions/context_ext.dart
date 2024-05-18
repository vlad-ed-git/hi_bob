import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hi_bob/core/ui/pop_ups/snack.dart';

/// breakpoint width for different form factors
const double largeDesktopWidth = 1200;
const double desktopWidth = 900;
const double tabletWidth = 600;
const double handsetWidth = 300;

/// Extension methods for the BuildContext class.

/// This extension provides convenient access to commonly used properties
/// and functionalities from the BuildContext.
extension ContextExt on BuildContext {
  AppLocalizations get translated => AppLocalizations.of(this)!;

  Brightness get brightness => Theme.of(this).brightness;

  ColorScheme get color => Theme.of(this).colorScheme;

  Brightness get phoneBrightness => MediaQuery.of(this).platformBrightness;

  bool get isDarkMode => brightness == Brightness.dark;

  bool get isLightMode => brightness == Brightness.light;

  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  ScreenType get formFactor {
    // Use .shortestSide to detect device type regardless of orientation
    double deviceWidth = MediaQuery.of(this).size.shortestSide;
    if (deviceWidth > desktopWidth) {
      return ScreenType.desktop;
    }
    if (deviceWidth > tabletWidth) {
      return ScreenType.tablet;
    }
    if (deviceWidth > handsetWidth) {
      return ScreenType.handset;
    }
    return ScreenType.watch;
  }

  double get stdSpace {
    switch (formFactor) {
      case ScreenType.watch:
        return 10.0;
      case ScreenType.handset:
        return 16.0;
      case ScreenType.tablet:
        return 18.0;
      case ScreenType.desktop:
        return 22.0;
    }
  }

  double get smSpace => stdSpace - 4;

  double get mdSpace => stdSpace + 4;

  double get lgSpace => stdSpace * 2;

  double get xlgSpace => lgSpace * 2;

  void showErrorSnack(String error) {
    final snack = Snack(
      content: error,
      isError: true,
    );
    final snackBar = snack.create(this);
    final messenger = ScaffoldMessenger.of(this);
    messenger.removeCurrentSnackBar();
    messenger.showSnackBar(snackBar, snackBarAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOutSine,
    ));
  }

  void showSuccessSnack(String msg) {
    final snack = Snack(
      content: msg,
    );
    final snackBar = snack.create(this);
    final messenger = ScaffoldMessenger.of(this);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(snackBar);
  }
  Future<void> removeSnack() async{
    await Future.delayed(Duration(milliseconds: 300), (){});
    final messenger = ScaffoldMessenger.of(this);
    messenger.removeCurrentSnackBar();
  }
}

enum ScreenType { watch, handset, tablet, desktop }
