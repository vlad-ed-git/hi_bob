part of 'user_preferences_bloc.dart';

sealed class UserPreferencesEvent extends Equatable {
  const UserPreferencesEvent();
}

class GetUserPreferencesEvent extends UserPreferencesEvent {
  @override
  List<Object> get props => [];
}

class ToggleDarkModeEvent extends UserPreferencesEvent {
  final UserPreferences currentPreferences;

  ToggleDarkModeEvent({
    required this.currentPreferences,
  });

  @override
  List<Object> get props => [
        currentPreferences,
      ];
}
