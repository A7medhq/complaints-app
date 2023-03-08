import 'package:flutter/material.dart';

class CustomActionChip extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const CustomActionChip({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onPressed,
      label: Text(
        title,
        style: TextStyle(color: Colors.grey.shade700),
      ),
      backgroundColor: Colors.grey.shade200,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    );
  }
}
