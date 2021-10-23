import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trendy_movies/src/application/services/database/layers/dblayer_base.dart';
import 'package:trendy_movies/src/application/utils/file_utils/file_utils_io.dart'
    if (dart.library.html) 'package:trendy_movies/src/application/utils/file_utils/file_utils_web.dart';
import 'package:trendy_movies/src/domain/services/base_database_service.dart';

typedef FactoryFunc<T> = T Function();

abstract class AppDatabaseService extends DatabaseService {
  @protected
  final Set<DBLayer<dynamic>> _dbLayers = {};

  static AppDatabaseService get() {
    return Get.find<AppDatabaseService>();
  }

  @protected
  @mustCallSuper
  void addDBLayer(DBLayer<dynamic> dbLayer) {
    _dbLayers.add(dbLayer);
    logger.debug('Layer ${dbLayer.runtimeType} added');
  }

  @override
  void onReady() {
    super.onReady();
    registerAdapters();
  }

  @override
  Future<void> initializeDB(String userid) async {
    try {
      await Hive.close();
      await Hive.initFlutter(userid);
      await _openBoxes();

      dbInitialized(true);
    } catch (e, s) {
      logger.error(
        error: e,
        stackTrace: s,
        isFatalError: true,
      );
      showDbError(e, s);
    }
  }

  @mustCallSuper
  @protected
  void registerAdapters() {
    for (final layer in _dbLayers) {
      layer.registerLayerAdapters();
    }
  }

  @mustCallSuper
  @protected
  Future<void> _openBoxes() async {
    logger.debug('Opening DB boxes .. ${_dbLayers.length}');
    for (final layer in _dbLayers) {
      await layer.openBox();
    }

    return;
  }

  @protected
  Future<void> compact() async {
    for (final layer in _dbLayers) {
      await layer.compact();
    }

    return;
  }

  Future<Box<T>> openForCurrentUser<T>(
    String boxName, {
    bool deleteOnError = false,
  }) async {
    try {
      return await Hive.openBox<T>(
        boxName,
        compactionStrategy: _compactionStrategy,
      );
    } catch (e, s) {
      logger.error(
        message: boxName,
        error: e,
        stackTrace: s,
        isFatalError: true,
      );
      if (deleteOnError && !kReleaseMode) {
        await Hive.deleteBoxFromDisk(boxName);

        return Hive.openBox<T>(
          boxName,
          compactionStrategy: _compactionStrategy,
        );
      } else {
        rethrow;
      }
    }
  }

  Future<Box<T>> openGlobal<T>(
    String boxName, {
    bool deleteOnError = true,
  }) async {
    try {
      final boxDir = await FileUtils().joinDirName(boxName);

      return await Hive.openBox<T>(
        boxName,
        compactionStrategy: _compactionStrategy,
        path: boxDir,
      );
    } catch (e, s) {
      logger.error(
        message: boxName,
        error: e,
        stackTrace: s,
        isFatalError: true,
      );
      if (deleteOnError && !kReleaseMode) {
        await Hive.deleteBoxFromDisk(boxName);

        return openGlobal(
          boxName,
          deleteOnError: false,
        );
      } else {
        rethrow;
      }
    }
  }

  bool _compactionStrategy(int entries, int deletedEntries) {
    return deletedEntries > 50;
  }

  @override
  Future<void> closeDB() async {
    await _closeBoxes();

    return;
  }

  Future<void> _closeBoxes() async {
    await compactBoxes();
    logger.debug('closing boxes');
    final futures = _dbLayers.map((e) => e.close());

    await Future.wait<dynamic>(futures);

    return;
  }

  Future<void> compactBoxes() {
    logger.debug('compacting boxes');

    final futures = _dbLayers.map((e) => e.compact());

    return Future.wait(futures);
  }

  ///on db loading error
  @override
  void showDbError(Object e, StackTrace s) {
    return;
  }

  @override
  void onClose() {
    closeDB();
    super.onClose();
  }
}
