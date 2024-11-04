import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageServices {
  //TODO: save image to app documents (subdirectory, image file)
  Future<File?> saveFileToAppDocument(String subDirectory, File file) async {

    Directory directory = await Directory('${await _localPath}/$subDirectory').create(recursive: true);

    final newFile = await file.copy('${directory.path}/${file.path.split('/').last}');

    return newFile;
  }
  //TODO: get image from path
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}