import 'package:get/get.dart';

abstract class DatabaseService extends GetxService {
  Future<void> initDb();
}
