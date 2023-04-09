import 'package:flutter/material.dart';

//Display snackbar / toast message on the app screen
void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      content: Text(
        message!,
      ),
    ),
  );
}
