import 'package:loggy/loggy.dart';
import 'package:trendy_movies/src/domain/providers/logger.dart';

class LoggerDevImpl extends Logger {
  late final _logger = Loggy<GlobalLoggy>('Dev');
  @override
  void onInit() {
    Loggy.initLoggy(
      hierarchicalLogging: true,
      logPrinter: const PrettyPrinter(
        showColors: true,
      ),
    );
  }

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.debug(message, error, stackTrace);
  }

  @override
  void error(Object error, [StackTrace? stackTrace, String? message]) {
    _logger.error(message, error, stackTrace);
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
  void info(String message) {
    _logger.info(message);
  }
}
