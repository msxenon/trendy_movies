import 'package:hive_flutter/hive_flutter.dart';
import 'package:terndy_movies/domain/database.dart';

class DatabaseServiceImpl extends DatabaseService {
  @override
  Future<void> initDb() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openAdapters();
    return;
  }

  void _registerAdapters() {
    registerAuthAdapter();
    return;
  }

  Future<void> _openAdapters() async {
    await openAuthAdapter();
    return;
  }
}
