import 'dart:io';

import 'package:path/path.dart' as path_helper;
import 'package:path_provider/path_provider.dart';

class FileUtils {
  Future<Directory> getApplicationDocumentsDir() {
    return getApplicationDocumentsDirectory();
  }

  Future<String> joinDirName(String newDirName) async {
    final appDir = await getApplicationDocumentsDir();

    return path_helper.join(appDir.path, newDirName);
  }
}
