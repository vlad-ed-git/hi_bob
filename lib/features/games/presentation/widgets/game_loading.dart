import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:hi_bob/core/ui/containers/containers.dart';

class GameLoading extends StatelessWidget {
  const GameLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeFullScreenContainer(
        padding: EdgeInsets.all(16),
        Center(
          child: CupertinoActivityIndicator(
            radius: 12,
          ),
        ),
    );
  }
}
