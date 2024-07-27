import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/text/app_text.dart';
import 'package:hi_bob/core/utils/extensions/context_ext.dart';

class Snack {
  final String content;
  final Function? action;
  final String actionLbl;
  final bool isError;

  const Snack({
    required this.content,
    this.action,
    this.actionLbl = '',
    this.isError = false,
  });

  SnackBar create(BuildContext context) {
    final bgColor = isError ? context.color.error : context.color.primary;
    final txtColor = isError ? context.color.onError : context.color.onPrimary;
    return SnackBar(
      elevation: 12.0,
      duration: const Duration(seconds: 5),
      content: P2(
        content,
        color: txtColor,
      ),
      action: action != null
          ? SnackBarAction(
              label: actionLbl.toUpperCase(),
              onPressed: () => action!(),
              backgroundColor: txtColor,
              textColor: bgColor,
            )
          : null,
      backgroundColor: bgColor,
    );
  }
}
