abstract class Logger {
  Logger() {
    onInit();
  }

  void onInit();
  void error(Object error, [StackTrace? stackTrace, String? message]);
  void debug(String message);
  void info(String message);

  void logWriter(String text, {bool? isError});
}
