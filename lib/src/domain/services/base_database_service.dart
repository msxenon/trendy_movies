import 'package:get/get.dart';
import 'package:trendy_movies/src/domain/services/base_service.dart';

abstract class DatabaseService extends BaseService {
  final RxBool dbInitialized = false.obs;

  ///awaited and called after login
  Future<void> initializeDB(String userid);

  Future<void> closeDB();

  ///on db loading error
  void showDbError(Object e, StackTrace s);

  @override
  void onClose() {
    dbInitialized(false);
    closeDB();
    super.onClose();
  }
}
