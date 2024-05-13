import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';
import 'package:hi_bob/features/home/presentation/widgets/home_tabs.dart';

class HomeScreen extends StatefulWidget {
  final StatefulNavigationShell goRouterHomePageNavShell;

  const HomeScreen({
    super.key,
    required this.goRouterHomePageNavShell,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final HomeTabs selectedPage =
        HomeTabs.values[widget.goRouterHomePageNavShell.currentIndex];
    return Scaffold(
      extendBody: true,
      body: widget.goRouterHomePageNavShell,
    );
  }

  void _navigateToTab(int selectedTabIndex) {
    widget.goRouterHomePageNavShell.goBranch(
      selectedTabIndex,
      initialLocation:
          selectedTabIndex == widget.goRouterHomePageNavShell.currentIndex,
    );
  }
}
