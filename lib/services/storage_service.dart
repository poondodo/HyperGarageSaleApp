import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as p;

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(
    String filePath,
    String fileName,
  ) async {
    File file = File(filePath);
    try {
      await storage.ref('zhu-and-pan/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print('following are firebase_core.FirebaseException: ');
      print(e);
    }
  }

  Future<String> upload(File file) async {
    try {
      String fileName = p.basename(file.path);
      await storage.ref('zhu-and-pan/$fileName').putFile(file);
      return await storage.ref('zhu-and-pan/$fileName').getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      print('following are firebase_core.FirebaseException: ');
      print(e);
    }
    return 'Error to get photo url';
  }
}
