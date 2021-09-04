import 'package:terndy_movies/domain/logger.dart';

class LoggerProdImpl extends Logger {
  ///here you can use sentry , crashlytics ... etc
  @override
  void onInit() {}

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {}

  @override
  void error(Object error, [StackTrace? stackTrace, String? message]) {}

  @override
  void info(String message) {}

  @override
  void logWriter(String text, {bool? isError}) {}
}
