import 'package:flutter/material.dart';

extension FormatWidgetList on List<Widget> {
  List<Widget> expandWithSpacing(double spacing) {
    final widgetsCount = length;
    List<Widget> expandedWidgets = [];
    for (int i = 0; i < widgetsCount; i++) {
      expandedWidgets.add(Expanded(child: this[i]));
      if (i < widgetsCount - 1)
        expandedWidgets.add(
          SizedBox(
            width: 8,
          ),
        ); // add spacing
    }
    return expandedWidgets;
  }
}
