import 'package:dartz/dartz.dart';
import 'package:hi_bob/features/user_preferences/domain/errors/user_preferences_failure.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';
import 'package:hi_bob/features/user_preferences/domain/repository/user_preferences_repository.dart';

class GetUserPreferencesUseCase {
  final UserPreferencesRepository _repo;

  const GetUserPreferencesUseCase(this._repo);

  Future<Either<UserPreferencesFailure, UserPreferences>> call() async {
    return _repo.getUserPreferences();
  }
}

class SetUserPreferencesUseCase {
  final UserPreferencesRepository _repo;

  const SetUserPreferencesUseCase(this._repo);

  Future<Either<UserPreferencesFailure, UserPreferences>> call(
    UserPreferences preferences,
  ) async {
    return _repo.setUserPreferences(preferences);
  }
}

class ListenToUserPreferencesChangesUseCase {
  final UserPreferencesRepository _repo;

  const ListenToUserPreferencesChangesUseCase(this._repo);

  Stream<UserPreferences?> call() {
    return _repo.listenToUserPreferencesChanges();
  }
}

class UserPreferencesUseCases {
  final GetUserPreferencesUseCase getPreferencesUseCase;
  final SetUserPreferencesUseCase setPreferencesUseCase;
  final ListenToUserPreferencesChangesUseCase listenToPreferencesChangesUseCase;

  const UserPreferencesUseCases(
    this.getPreferencesUseCase,
    this.setPreferencesUseCase,
    this.listenToPreferencesChangesUseCase,
  );
}
