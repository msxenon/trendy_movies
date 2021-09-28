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
  void error(Object error, [StackTrace? stackTrace, String? message]) {
    return;
  }

  @override
  void info(String message) {
    return;
  }

  @override
  void logWriter(String text, {bool? isError}) {
    return;
  }
}
