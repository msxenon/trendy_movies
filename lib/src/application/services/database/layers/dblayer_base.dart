import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:trendy_movies/src/application/services/database/hive_database_service.dart';
import 'package:trendy_movies/src/domain/base_dependency_container.dart';

abstract class DBLayer<T> with BaseToolBox {
  String get boxName;
  bool get isGlobal => false;
  bool get deleteOnError;
  Box<T> get box => _box!;
  Box<T>? _box;
  final RxBool isReady = false.obs;

  Future<void> close() {
    isReady.value = false;

    return box.close();
  }

  Future<void> compact() {
    return box.compact();
  }

  Future<void> openBox() async {
    try {
      _box = isGlobal
          ? await database.openGlobal<T>(boxName)
          : await database.openForCurrentUser<T>(
              boxName,
            );
      isReady.value = _box != null;
      logger.debug('DBLayer: ${runtimeType.toString()} : $boxName opened');
    } catch (e, s) {
      logger.error(
        message: 'DBLayer: ${runtimeType.toString()} : $boxName',
        error: e,
        stackTrace: s,
        isFatalError: true,
      );
    }

    return;
  }

  void registerLayerAdapters();

  @override
  int get hashCode => boxName.hashCode;
  @override
  bool operator ==(Object other) {
    return (other is DBLayer<T>) && other.boxName == boxName;
  }
}

void registerAdapter<X>(FactoryFunc<TypeAdapter<X>> adapter) {
  final _adapter = adapter();
  if (!Hive.isAdapterRegistered(_adapter.typeId)) {
    Hive.registerAdapter<X>(_adapter);
    di.logger.debug(
      'Adapter Registered => ${X.runtimeType} == ${adapter.runtimeType}',
    );
  } else {
    di.logger
        .debug('Adapter already registered => ${adapter.runtimeType} Skipped');
  }
}
