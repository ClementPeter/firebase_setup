import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_manual/utils/failure.dart';
import 'package:firebase_manual/utils/snackbar.dart';
import 'package:flutter/material.dart';

class Database {
  CollectionReference posts = FirebaseFirestore.instance.collection("posts");

  Future createPost({String? postMessage, BuildContext? context}) async {
    try {
      return await posts
          .add({
            "post": postMessage,
            "createdAt": DateTime.now(),
          })
          .then((value) => print("Post Added"))
          .catchError((error) => print("Failed to add post: $error"));
    } on FirebaseException {
      showMessage(
          context: context,
          message: "Firebase Exception : Failed to to create a post");
      throw Failure(message: "Firebase Exception : Failed to to create a post");
    } on SocketException {
      showMessage(context: context, message: "Check your Internet Connection");
      throw Failure(message: "Internet Connection failed");
    } catch (e) {
      print(e.toString());
      throw Failure(message: e.toString());
    }
  }
}
