import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart' if (dart.library.html) 'src/stub/path.dart'
    as path_helper;
import 'package:path_provider/path_provider.dart'
    if (dart.library.html) 'src/stub/path_provider.dart';
import 'package:trendy_movies/src/application/services/database/layers/dblayer_base.dart';
import 'package:trendy_movies/src/domain/services/base_database_service.dart';

typedef FactoryFunc<T> = T Function();

abstract class AppDatabaseService extends DatabaseService {
  @protected
  final Set<DBLayer<dynamic>> dbLayers = {};

  static AppDatabaseService get() {
    return Get.find<AppDatabaseService>();
  }

  @protected
  @mustCallSuper
  void onAddDBLayer() {}

  @override
  void onReady() {
    onAddDBLayer();
    super.onReady();
    registerAdapters();
  }

  @override
  Future<void> initializeDB(String userid) async {
    try {
      await Hive.close();
      await Hive.initFlutter(userid);

      final decoded = base64Url.decode(userid);
      final encryptionKey = decoded;

      await _openEncryptedBoxes(encryptionKey);

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
    for (final layer in dbLayers) {
      layer.registerLayerAdapters();
    }
  }

  @mustCallSuper
  @protected
  Future<void> _openEncryptedBoxes(Uint8List? cipher) async {
    if (cipher == null) {
      throw Exception('db cipher is null');
    }
    logger.debug('Opening encrypted boxes');
    final hiveCipher = HiveAesCipher(cipher);
    for (final layer in dbLayers) {
      await layer.openBox(hiveCipher);
    }

    return;
  }

  @protected
  Future<void> compact() async {
    for (final layer in dbLayers) {
      await layer.compact();
    }
    return;
  }

  Future<Box<T>> openForCurrentUser<T>(
    String boxName, {
    required HiveAesCipher cipher,
    bool deleteOnError = false,
  }) async {
    try {
      return await Hive.openBox<T>(
        boxName,
        encryptionCipher: cipher,
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
          encryptionCipher: cipher,
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
      final appDir = await getApplicationDocumentsDirectory();
      final String customPath = path_helper.join(appDir.path, boxName);
      return await Hive.openBox<T>(
        boxName,
        compactionStrategy: _compactionStrategy,
        path: customPath,
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
    final futures = dbLayers.map((e) => e.close());

    await Future.wait<dynamic>(futures);
    return;
  }

  Future<void> compactBoxes() {
    logger.debug('compacting boxes');

    final futures = dbLayers.map((e) => e.compact());
    return Future.wait(futures);
  }

  ///on db loading error
  @override
  void showDbError(Object e, StackTrace s) {}

  @override
  void onClose() {
    closeDB();
    super.onClose();
  }
}
