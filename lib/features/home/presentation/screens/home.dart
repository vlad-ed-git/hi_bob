import 'package:flutter/material.dart';
import 'package:go_router/src/route.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';
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
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: HomeTabs.values.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeTabs selectedPage =
    HomeTabs.values[widget.goRouterHomePageNavShell.currentIndex];
    return Scaffold(
      extendBody: true,
      body: widget.goRouterHomePageNavShell,
      bottomNavigationBar: Material(
        color: context.color.surface,
        elevation: 8,
        child: Container(
          height: 98,
          child: TabBar(
            controller: _tabController,
            indicator: TopIndicator(
              color: context.color.primary,
            ),
            onTap: _navigateToTab,
            padding: EdgeInsets.only(
              bottom: 34,
            ),
            dividerHeight: 0,
            splashBorderRadius: BorderRadius.zero,
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                }),
            tabs: HomeTabs.values
                .map(
                  (e) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  selectedPage == e
                      ? e.selectedIcon(context)
                      : e.unselectedIcon(context),
                  HintText(
                    e.label(context),
                    color: selectedPage == e
                        ? context.color.primary
                        : context.color.onSurface,
                  ),
                ],
              ),
            )
                .toList(growable: false),
          ),
        ),
      ),
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

class TopIndicator extends Decoration {
  final Color color;

  TopIndicator({
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TopIndicatorBox(color);
  }
}

class _TopIndicatorBox extends BoxPainter {
  final Color color;

  _TopIndicatorBox(this.color);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    Paint _paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..isAntiAlias = true;

    canvas.drawLine(offset, Offset(cfg.size!.width + offset.dx, 0), _paint);
  }
}