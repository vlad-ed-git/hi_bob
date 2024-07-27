import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hi_bob/core/ui/assets/app_icons.dart';
import 'package:hi_bob/core/ui/images/svgs/svg_icon.dart';
import 'package:hi_bob/features/user_preferences/presentation/state/user_preferences/user_preferences_bloc.dart';
import 'package:hi_bob/flavor_config.dart';

class ToggleDarkMode extends StatefulWidget {
  final Color iconColor;
  final double iconSize;

  const ToggleDarkMode({
    super.key,
    required this.iconColor,
    this.iconSize = 24,
  });

  @override
  State<ToggleDarkMode> createState() => _ToggleDarkModeState();
}

class _ToggleDarkModeState extends State<ToggleDarkMode> {
  UserPreferencesBloc? _stateHandler;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (BuildContext blocProviderContext) =>
          GetIt.instance<UserPreferencesBloc>(),
      child: BlocListener<UserPreferencesBloc, UserPreferencesState>(
        listener: _onStateChanged,
        child: BlocBuilder<UserPreferencesBloc, UserPreferencesState>(
          builder: (blocContext, state) {
            _initializeStateHandler(blocContext);
            return IconButton(
              onPressed: () {
                _stateHandler?.add(
                  ToggleDarkModeEvent(
                    currentPreferences: FlavorConfig.instance.preferences,
                  ),
                );
              },
              icon: Icon(
              FlavorConfig.instance.preferences.prefersDarkMode
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_outlined,
                size: widget.iconSize,
                color: widget.iconColor,
              ),
            );
          },
        ),
      ),
    );
  }

  void _initializeStateHandler(BuildContext blocContext) {
    if (_stateHandler != null) {
      return;
    }
    _stateHandler ??= BlocProvider.of<UserPreferencesBloc>(blocContext);
    _stateHandler?.add(GetUserPreferencesEvent());
  }

  void _onStateChanged(BuildContext context, UserPreferencesState state) {
    if (state is LoadedUserPreferencesState) {
      FlavorConfig.instance.preferences = state.preferences;
    }
  }
}
