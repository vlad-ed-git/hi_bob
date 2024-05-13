// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';

void kDebugPrint(String s) {
  if (!kDebugMode) {
    return;
  }

  /// allows for printing long messages
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(s).forEach((match) => print(match.group(0)));
}
