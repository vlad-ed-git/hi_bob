import 'package:get_it/get_it.dart';
import 'package:hi_bob/features/user_preferences/data/local_data_source/user_preferences_local_data_source.dart';
import 'package:hi_bob/features/user_preferences/data/local_data_source/user_preferences_local_data_source_impl.dart';
import 'package:hi_bob/features/user_preferences/data/local_data_source/user_preferences_sql_dao.dart';
import 'package:hi_bob/features/user_preferences/data/repository/user_preferences_repository_impl.dart';
import 'package:hi_bob/features/user_preferences/domain/repository/user_preferences_repository.dart';
import 'package:hi_bob/features/user_preferences/domain/usecases/user_preferences_usecases.dart';
import 'package:hi_bob/features/user_preferences/presentation/state/user_preferences/user_preferences_bloc.dart';

void init() {
  final GetIt di = GetIt.instance;

  di.registerLazySingleton<UserPreferencesLocalSource>(
    UserPreferencesLocalSourceImpl.new,
  );
  di.registerLazySingleton<UserPreferencesRepository>(
    () => UserPreferencesRepositoryImpl(
      di(),
      di(),
    ),
  );
  di.registerLazySingleton<GetUserPreferencesUseCase>(
    () => GetUserPreferencesUseCase(
      di(),
    ),
  );
  di.registerLazySingleton<ListenToUserPreferencesChangesUseCase>(
    () => ListenToUserPreferencesChangesUseCase(
      di(),
    ),
  );
  di.registerLazySingleton<SetUserPreferencesUseCase>(
    () => SetUserPreferencesUseCase(
      di(),
    ),
  );

  di.registerLazySingleton<UserPreferencesUseCases>(
    () => UserPreferencesUseCases(
      di(),
      di(),
      di(),
    ),
  );

  di.registerFactory(
    () => UserPreferencesBloc(
      di(),
      di(),
    ),
  );
}
