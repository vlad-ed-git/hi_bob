import 'package:flutter/material.dart';

class RoundLoadingIndicator extends StatelessWidget {
  final Color? bgColor, onBgColor;
  final double size;

  const RoundLoadingIndicator({
    super.key,
    this.size = 24,
    this.bgColor,
    this.onBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: bgColor,
            color: onBgColor,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
