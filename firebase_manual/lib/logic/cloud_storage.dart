import 'dart:io';

import 'package:firebase_manual/model/cloud_storage_result.dart';
import 'package:firebase_storage/firebase_storage.dart';

//Logic to upload selected image to Firebase cloud storage

final storage = FirebaseStorage.instance;

class CloudUpload {
  //pass selected image into the function
  Future<CloudStorageResult> imageUpload(File? pickedImage) async {
    //give uploaded files unique names using data-time
    var imageName = "IMG" + DateTime.now().toString();

    //create a storage bucket in firebase storage
    final storage = FirebaseStorage.instance.ref().child(imageName);

    //upload file to firebase storage
    await storage.putFile(pickedImage!);

    //get download url
    final downloadUrl = await storage.getDownloadURL();

    //return the modelled Cloud storage result data
    return CloudStorageResult(imageName: imageName, imageUrl: downloadUrl);
  }
}
