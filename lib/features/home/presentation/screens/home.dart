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
    return Scaffold(
      extendBody: true,
      body: widget.goRouterHomePageNavShell,
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