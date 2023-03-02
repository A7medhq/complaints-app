import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  String hint;

  TextEditingController controller;
  AuthTextField({super.key, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade400),
          hintText: hint,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff3A98B9)))),
    );
  }
}
