part of 'user_preferences_bloc.dart';

sealed class UserPreferencesState extends Equatable {
  const UserPreferencesState();
}

final class UserPreferencesInitial extends UserPreferencesState {
  @override
  List<Object> get props => [];
}

class LoadingUserPreferencesState extends UserPreferencesState {
  @override
  List<Object> get props => [];
}

class LoadedUserPreferencesState extends UserPreferencesState {
  final UserPreferences preferences;

  LoadedUserPreferencesState({
    required this.preferences,
  });

  @override
  List<Object> get props => [preferences];
}

class LoadingUserPreferencesFailedState extends UserPreferencesState {
  final UserPreferencesErrors error;

  LoadingUserPreferencesFailedState(this.error);

  @override
  List<Object> get props => [error];
}
