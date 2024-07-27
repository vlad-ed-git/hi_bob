import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class Shimmering extends StatelessWidget {
  final Widget child;

  const Shimmering(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ShimmerEffect(
          color: context.isDarkMode ? Color(0x80202020) : Color(0x80FFFFFF),
          duration: Duration(seconds: 1),
          angle: 0.0,
        ),
      ],
      onPlay: (controller) => controller.repeat(),
      child: child,
    );
  }
}
