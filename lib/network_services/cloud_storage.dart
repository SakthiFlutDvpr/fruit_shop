import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  static String storageName = "Images";
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Reference ref = storage.ref().child(storageName);

  static Future<String> uploadImage(XFile imageFile, String id) async {
    UploadTask uploadTask = ref.child(id).putFile(File(imageFile.path));
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      ///////////////////////////////////////////////////////////////////
    });

    TaskSnapshot taskSnapshot = await uploadTask;

    debugPrint("image uploaded successfully");

    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  static Future<dynamic> getImageUrl(String id) async {
    try {
      String imageUrl = await ref.child(id).getDownloadURL();
      debugPrint("image downloaded successfully");
      return imageUrl;
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
