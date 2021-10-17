import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';

class LoggerDevImpl extends LoggerService {
  LoggerDevImpl()
      : _logger = Logger(
          filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
          printer: PrettyPrinter(
            printTime: true,
            methodCount: 4,
            lineLength: 80,
          ),
        );
  final Logger _logger;

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  @override
  void logWriter(String text, {bool? isError}) {
    if (text == 'null') {
      return;
    }
    if (isError == true) {
      _logger.w(text);
    } else {
      info(text);
    }
  }

  @override
  void info(String message, {bool sendRemote = false}) {
    _logger.i(message);
  }

  @override
  void error({
    String? message,
    Object? error,
    StackTrace? stackTrace,
    bool isFatalError = false,
  }) {
    _logger.e(message, error, stackTrace);
  }
}
