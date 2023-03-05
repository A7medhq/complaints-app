import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  Widget child;

  RoundedContainer({
    super.key,
    required Widget this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(28)),
        child: child);
  }
}
