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

}
