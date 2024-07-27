import 'package:hi_bob/core/error_handling/domain/repository/log_errors.dart';
import 'package:hi_bob/core/utils/k_debug_print.dart';

class LogErrorsImpl implements LogErrors {
  @override
  void log({
    required String callerClass,
    required String callerMethod,
    required dynamic error,
    StackTrace? stackTrace,
    bool logToServer = false,
  }) {
    kDebugPrint(
      'Hi Bob App Error Logger >>>>>>>>>> :\n $callerClass.$callerMethod\n$error\n${stackTrace ?? 'No Stack Trace Info'}',
    );
    if (!logToServer) {
      return;
    }

    // TODO(vlad-ed-git): implement log to server
  }
}
