import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DBManager {
  String? downloadURL;

  Future getData(String name) async {
    try {
      await downloadURLFor(name);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadURLFor(String name) async {
    downloadURL = await FirebaseStorage.instance
        .ref()
        .child("$name.png")
        .getDownloadURL();
    log(downloadURL.toString());
  }
}