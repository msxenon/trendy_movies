import 'package:flutter/foundation.dart';
import 'package:loggy/loggy.dart';

/// Format log and add emoji to represent the color.
///
/// [showColors] - default:false
/// This uses ANSI escape characters and it will be visible only in terminal.
/// IDE-s mostly don't support them and you will only end up with log that has
/// weird prefix and suffix.
///
/// Format:
/// *EMOJI* *TIME* *LOG PRIORITY*  *LOGGER NAME* - *CLASS NAME* - *LOG MESSAGE*
class CustomLogPrinter extends LoggyPrinter {
  const CustomLogPrinter() : super();

  static final _levelColors = {
    LogLevel.debug:
        AnsiColor(foregroundColor: AnsiColor.grey(0.5), italic: true),
    LogLevel.info: AnsiColor(foregroundColor: 35),
    LogLevel.warning: AnsiColor(foregroundColor: 214),
    LogLevel.error: AnsiColor(foregroundColor: 196),
  };

  static final _levelPrefixes = {
    LogLevel.debug: '🐛 ',
    LogLevel.info: '👻 ',
    LogLevel.warning: '⚠️ ',
    LogLevel.error: '‼️ ',
  };

  static const _defaultPrefix = '🤔 ';

  @override
  void onLog(LogRecord record) {
    final _time = record.time.toIso8601String().split('T')[1];
    final _callerFrame =
        record.callerFrame == null ? '-' : '(${record.callerFrame?.location})';
    final _logLevel = record.level
        .toString()
        .replaceAll('Level.', '')
        .toUpperCase()
        .padRight(8);

    final _color = levelColor(record.level) ?? AnsiColor();
    final _prefix = levelPrefix(record.level) ?? _defaultPrefix;

    debugPrint(
      _color(
        '$_prefix$_time $_logLevel ${record.loggerName} $_callerFrame ${record.message}',
      ),
      wrapWidth: 100000000,
    );

    if (record.stackTrace != null) {
      debugPrint(
        record.stackTrace.toString(),
        wrapWidth: 100000000,
      );
    }
  }

  String? levelPrefix(LogLevel level) {
    return _levelPrefixes[level];
  }

  AnsiColor? levelColor(LogLevel level) {
    return _levelColors[level];
  }
}
