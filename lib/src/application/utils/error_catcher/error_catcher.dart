import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

typedef FutureFunction = Future<void> Function();

class ErrorCatcher {
  ErrorCatcher(FutureFunction appRunner) {
    _initFlutterError();
    _run(appRunner);
  }
  void _run(FutureFunction appRunner) {
    Chain.capture(
      () async {
        await appRunner();
      },
      errorZone: true,
      onError: (error, stackChain) async {
        di.logger.error(
          message: 'runZonedGuarded',
          error: error,
          stackTrace: stackChain,
          isFatalError: true,
        );
      },
    );
  }

  void _initFlutterError() {
    // an internal FlutterError reporter that dumps to console
    FlutterError.onError = (FlutterErrorDetails details) async {
      final x = TextTreeRenderer(
        wrapWidthProperties: 100,
        maxDescendentsTruncatableNode: 5,
      )
          .render(
            details.toDiagnosticsNode(style: DiagnosticsTreeStyle.error),
          )
          .trimRight();

      di.logger.error(
        message: 'FlutterError $x',
        error: details.exception,
        stackTrace: details.stack,
        isFatalError: true,
      );
    };
  }
}
