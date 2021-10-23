import 'dart:io';

class FileUtils {
  Future<Directory> getApplicationDocumentsDir() async {
    return Directory('/');
  }

  Future<String> joinDirName(String newDirName) async {
    final appDir = await getApplicationDocumentsDir();

    return '$appDir/$newDirName';
  }
}
