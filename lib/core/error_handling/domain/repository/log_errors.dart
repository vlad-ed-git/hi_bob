/// Defines a contract for logging errors.
abstract class LogErrors {
  /// Logs an error message.
  ///
  ///* [callerClass] : The name of the class where the error occurred.
  ///* [callerMethod] : The name of the method where the error occurred.
  ///* [error] : The  error object to be logged.
  ///* [stackTrace] (optional): An optional stack trace associated with the error.
  ///* [logToServer] (optional): A flag indicating whether to log the error
  ///   to a remote server in addition to the local logs. Defaults to `false`.
  void log({
    required String callerClass,
    required String callerMethod,
    required dynamic error,
    StackTrace? stackTrace,
    bool logToServer = false,
  });
}
