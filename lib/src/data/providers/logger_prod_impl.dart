import 'package:trendy_movies/src/domain/providers/logger.dart';

class LoggerProdImpl extends Logger {
  ///here you can use sentry , crashlytics ... etc
  @override
  void onInit() {
    return;
  }

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    return;
  }

  @override
  void logWriter(String text, {bool? isError}) {
    return;
  }

  @override
  void error(
      {String? message,
      Object? error,
      StackTrace? stackTrace,
      bool isFatalError = false}) {
    return;
  }

  @override
  void info(String message, {bool sendRemote = false}) {
    return;
  }
}
