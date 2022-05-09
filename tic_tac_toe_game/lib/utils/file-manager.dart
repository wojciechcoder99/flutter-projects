import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/rankingTop1.txt');
  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> writeLine(String line) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$line', mode: FileMode.append);
  }
}
