import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hi_bob/core/utils/extensions/dartz_ext.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_errors.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';
import 'package:hi_bob/features/user_preferences/domain/usecases/user_preferences_usecases.dart';

part 'user_preferences_event.dart';
part 'user_preferences_state.dart';

class UserPreferencesBloc
    extends Bloc<UserPreferencesEvent, UserPreferencesState> {
  final GetUserPreferencesUseCase _getUserPreferencesUseCase;
  final SetUserPreferencesUseCase _setUserPreferencesUseCase;

  UserPreferencesBloc(
    this._getUserPreferencesUseCase,
    this._setUserPreferencesUseCase,
  ) : super(UserPreferencesInitial()) {
    on<GetUserPreferencesEvent>(_onGetUserPreferencesEvent);
    on<ToggleDarkModeEvent>(_onToggleDarkModeEvent);
  }

  FutureOr<void> _onToggleDarkModeEvent(
    ToggleDarkModeEvent event,
    Emitter<UserPreferencesState> emit,
  ) async {
    emit(LoadingUserPreferencesState());
    final result = await _setUserPreferencesUseCase(
      event.currentPreferences.toggleDarkMode(),
    );
    if (result.isError) {
      emit(
        LoadingUserPreferencesFailedState(
          result.asFailure().userPreferencesError,
        ),
      );
      return;
    }
    emit(LoadedUserPreferencesState(preferences: result.asSuccess()));
  }

  FutureOr<void> _onGetUserPreferencesEvent(
    GetUserPreferencesEvent event,
    Emitter<UserPreferencesState> emit,
  ) async {
    emit(LoadingUserPreferencesState());
    final result = await _getUserPreferencesUseCase();
    if (result.isError) {
      emit(
        LoadingUserPreferencesFailedState(
          result.asFailure().userPreferencesError,
        ),
      );
      return;
    }
    emit(LoadedUserPreferencesState(preferences: result.asSuccess()));
  }
}
