import 'package:loggy/loggy.dart';
import 'package:terndy_movies/domain/logger.dart';

class LoggerDevImpl extends Logger {
  late final _logger = GlobalLoggy().loggy;
  @override
  void onInit() {
    Loggy.initLoggy(
        hierarchicalLogging: true,
        logPrinter: const PrettyPrinter(showColors: true));
  }

  @override
  void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.debug(message, error, stackTrace);
  }

  @override
  void error(Object error, [StackTrace? stackTrace, String? message]) {
    _logger.error(message, error, stackTrace);
  }
}
