import 'package:loggy/loggy.dart';
import 'package:trendy_movies/src/application/utils/error_catcher/log_printer.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';

class LoggerDevImpl extends Logger {
  late final _logger = Loggy<GlobalLoggy>('Dev');
  @override
  void onInit() {
    Loggy.initLoggy(
      logOptions: const LogOptions(
        LogLevel.all,
        stackTraceLevel: LogLevel.all,
        includeCallerInfo: true,
        callerFrameDepthLevel: 10000000,
      ),
      hierarchicalLogging: true,
      logPrinter: const CustomLogPrinter(),
    );
  }

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.debug(message, error, stackTrace);
  }

  @override
  void logWriter(String text, {bool? isError}) {
    if (isError == true) {
      _logger.warning(error);
    } else {
      info(text);
    }
  }

  @override
  void info(String message, {bool sendRemote = false}) {
    _logger.info(message);
  }

  @override
  void error({
    String? message,
    Object? error,
    StackTrace? stackTrace,
    bool isFatalError = false,
  }) {
    _logger.error(message, error, stackTrace);
  }
}
