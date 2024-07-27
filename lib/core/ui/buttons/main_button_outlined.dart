import 'package:flutter/material.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class MainBtnOutline extends StatelessWidget {
  final VoidCallback? onClick;
  final Widget child;
  final Color? borderColor, bgColor;
  final double height;

  const MainBtnOutline({
    super.key,
    this.onClick,
    required this.child,
    this.borderColor,
    this.bgColor,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.maxAllowedScreenWidth,
            height,
          ),
        ),
        side: MaterialStatePropertyAll(
          BorderSide(
            color: borderColor ?? context.color.primary,
          ),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(),
        ),
        elevation: MaterialStatePropertyAll(
          0.0,
        ),
        backgroundColor: MaterialStatePropertyAll(
          bgColor,
        ),
      ),
      onPressed: onClick,
      child: child,
    );
  }
}
