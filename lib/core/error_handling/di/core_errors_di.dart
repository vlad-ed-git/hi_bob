import 'package:get_it/get_it.dart';
import 'package:hi_bob/core/error_handling/data/repository/log_errors_impl.dart';
import 'package:hi_bob/core/error_handling/domain/repository/log_errors.dart';

void init() {
  final GetIt di = GetIt.instance
    ..registerLazySingleton<LogErrors>(LogErrorsImpl.new);
}
