import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/assets/app_icons.dart';
import 'package:hi_bob/core/ui/images/svgs/svg_icon.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

/// The main navigation tabs on the home screen
enum HomeTabs {
  main('home'),
  profile('profile');

  const HomeTabs(this.tabName);

  final String tabName;

  Icon selectedIcon(BuildContext context){
    IconData iconData;
    switch(this){
      case HomeTabs.main:
        iconData = Icons.home;
      case HomeTabs.profile:
        iconData = Icons.person_outline_sharp;
    }
    return Icon(iconData,
      size: 24,
      color: context.color.primary,
    );
  }

  Icon unselectedIcon(BuildContext context){
    IconData iconData;
    switch(this){
      case HomeTabs.main:
        iconData = Icons.home;
      case HomeTabs.profile:
        iconData = Icons.person_outline_sharp;
    }
    return Icon(iconData,
      size: 24,
      color: context.color.onSurface,
    );
  }

  String label(BuildContext context){
    switch(this){

      case HomeTabs.main:
        return context.translated.homeTabTitle;
      case HomeTabs.profile:
        return context.translated.profileTabTitle;
    }
  }

}
