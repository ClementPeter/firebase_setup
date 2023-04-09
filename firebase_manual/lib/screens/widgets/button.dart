import 'package:flutter/material.dart';

Widget button({
  BuildContext? context,
  String? text,
  Color? buttonColor,
  double? width,
  double? height,
  @required VoidCallback? onPressed,
}) {
  return GestureDetector(
    onTap: onPressed!,
    child: Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}
