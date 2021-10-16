import 'package:flutter/foundation.dart';

abstract class Logger {
  Logger() {
    onInit();
  }

  void onInit();
  void error({
    String? message,
    Object? error,
    StackTrace? stackTrace,
    bool isFatalError = false,
  });
  void debug(String message);
  void info(
    String message, {
    bool sendRemote = false,
  });

  void logWriter(String text, {bool? isError});
  @protected
  void reportErrorToRemote({
    Object? error,
    String? message,
    StackTrace? stackTrace,
    bool isFatalError = false,
  }) {
    ///not used yet
    return;
  }
}
