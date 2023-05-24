import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(File file) async {
  final metadata = SettableMetadata(contentType: 'image/jpeg');
  final storageRef = FirebaseStorage.instance.ref();

  Reference ref =
      storageRef.child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
  final uploadTask = ref.putFile(file, metadata);
  final taskSnapshot = await uploadTask.whenComplete(() => null);

  String url = await taskSnapshot.ref.getDownloadURL();
  return url;
}
