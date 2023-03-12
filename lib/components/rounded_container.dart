import 'package:complaints/views/message_detailes.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  Widget child;
  dynamic mail;

  RoundedContainer({
    super.key,
    required this.child,
    required this.mail,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: mail != null
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MessageDetailsScreen(
                            mail: mail!,
                          )));
            }
          : null,
      child: Container(
          clipBehavior: Clip.hardEdge,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(28)),
          child: child),
    );
  }
}
