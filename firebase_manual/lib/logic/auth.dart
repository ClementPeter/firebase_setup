import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_manual/utils/failure.dart';
import 'package:firebase_manual/utils/snackbar.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //Sign Up method with Firebase Auth
  Future<UserCredential> register({String? email, String? password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return user;
    } on FirebaseAuthException {
      throw Failure(message: "Firebase Authentication Failed");
    } on SocketException {
      throw Failure(message: "No Internet Connection");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }

  //Sign In method with Firebase Auth
  Future<UserCredential> signIn(
      {String? email, String? password, BuildContext? context}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return user;
    } on FirebaseAuthException {
      showMessage(
          context: context,
          message: "Firebase Exception : Failed to to create a post");
      throw Failure(message: "Firebase Authentication Failed");
    } on SocketException {
      showMessage(context: context, message: "Check your Internet Connection");
      throw Failure(message: "No Internet Connection");
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
