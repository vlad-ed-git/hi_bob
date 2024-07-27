import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  final bool isOn;
  final void Function({required bool turnOn}) onToggled;

  const AppSwitch({
    super.key,
    required this.isOn,
    required this.onToggled,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: Switch(
          value: isOn,
          trackOutlineWidth: MaterialStatePropertyAll(
            0,
          ),
          trackOutlineColor: MaterialStatePropertyAll(Colors.transparent),
          onChanged: (bool turnOn) => onToggled(turnOn: turnOn),
        ),
      ),
    );
  }
}
