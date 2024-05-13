import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/loading/round_loading_indicator.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class MainBtn extends StatelessWidget {
  final Widget child;
  final Color? bgColor, onBgColor;
  final BorderSide borderSide;
  final double radius;
  final VoidCallback onClick;
  final bool showLoading, isDisabled;
  final double height, width;
  final EdgeInsets? padding;
  final bool fitContentSize;

  const MainBtn({
    super.key,
    required this.child,
    this.bgColor,
    this.onBgColor,
    required this.onClick,
    this.radius = 0,
    this.borderSide = BorderSide.none,
    this.showLoading = false,
    this.height = 44,
    this.width = 104,
    this.isDisabled = false,
    this.padding,
    this.fitContentSize = false,
  });

  @override
  Widget build(BuildContext context) {
    final btnColor = bgColor ?? context.color.primary;
    final onBtnColor = onBgColor ?? context.color.onPrimary;
    if (showLoading) {
      return RoundLoadingIndicator(
        bgColor: btnColor,
        onBgColor: onBtnColor,
      );
    }
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          btnColor.withOpacity(isDisabled ? 0.3 : 1),
        ),
        fixedSize: !fitContentSize
            ? MaterialStatePropertyAll(
                Size(width, height),
              )
            : null,
        elevation: MaterialStatePropertyAll(
          0.0,
        ),
        padding: padding == null ? null : MaterialStatePropertyAll(padding!),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: borderSide,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
      onPressed: isDisabled ? null : onClick,
      child: child,
    );
  }
}
