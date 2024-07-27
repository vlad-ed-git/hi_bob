import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hi_bob/core/ui/assets/app_icons.dart';

class SvgIcon extends StatelessWidget {
  final AppSvgIcons appIcon;
  final String semanticLabel;
  final Color? color;
  final double width, height;

  const SvgIcon({
    super.key,
    required this.appIcon,
    this.semanticLabel = '',
    this.color,
    this.width = 24,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      appIcon.svgPath,
      width: width,
      height: height,
      colorFilter:
          color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      semanticsLabel: semanticLabel,
    );
  }
}
