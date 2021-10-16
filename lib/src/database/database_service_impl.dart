import 'package:hive_flutter/hive_flutter.dart';
import 'package:trendy_movies/src/domain/repo/database.dart';

class DatabaseServiceImpl extends DatabaseService {
  @override
  Future<void> initDb() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openAdapters();

    return;
  }

  void _registerAdapters() {
    return;
  }

  Future<void> _openAdapters() async {
    return;
  }
}