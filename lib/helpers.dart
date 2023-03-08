import 'package:flutter/material.dart';

void showSnackBar(
    {required BuildContext context,
    Color color = Colors.green,
    required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      content: Container(
        height: 25,
        child: Center(
            child: Text(
          "$message",
          style: TextStyle(fontWeight: FontWeight.w700),
        )),
      ),
    ),
  );
}
