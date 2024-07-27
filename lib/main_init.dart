import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hi_bob/core/error_handling/di/core_errors_di.dart'
    as core_error_handling_di;
import 'package:hi_bob/core/error_handling/domain/repository/log_errors.dart';
import 'package:hi_bob/core/services/di/core_services_di.dart'
    as core_services_di;
import 'package:hi_bob/features/user_preferences/data/local_data_source/user_preferences_local_data_source.dart';
import 'package:hi_bob/features/user_preferences/di/user_preferences_di.dart'
    as user_preferences_dependencies;

class MainInit {
  static Future<void> init() async {
    await _initDependencies();
    MainInit().registerErrorHandlers();
  }

  void registerErrorHandlers() {
    FlutterError.onError = (FlutterErrorDetails details) {
      GetIt.I<LogErrors>().log(
        callerClass: 'MainInit',
        callerMethod: 'registerErrorHandlers',
        error: 'FlutterError.onError caught an error',
        stackTrace: details.stack,
        logToServer: true,
      );
      // In development mode simply print to console.
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    // register errors from underlying platform
    PlatformDispatcher.instance.onError = (error, stack) {
      GetIt.I<LogErrors>().log(
        callerClass: 'MainInit',
        callerMethod: 'registerErrorHandlers',
        error: 'PlatformDispatcher.instance.onError caught an error $error',
        stackTrace: stack,
        logToServer: true,
      );
      return true;
    };
  }

  static Future<void> _initDependencies() async {
    core_error_handling_di.init();
    core_services_di.init();
    user_preferences_dependencies.init();
  }

  static void dispose() {
    // for any dispose work needed to be done on app disposed | note that this is not a async method
    GetIt.I<UserPreferencesLocalSource>().dispose();
  }
}
