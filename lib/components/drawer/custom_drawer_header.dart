import 'package:complaints/constants.dart';
import 'package:flutter/material.dart';

class CustomHeaderDrawer extends StatefulWidget {
  const CustomHeaderDrawer({Key? key}) : super(key: key);

  @override
  State<CustomHeaderDrawer> createState() => _CustomHeaderDrawerState();
}

class _CustomHeaderDrawerState extends State<CustomHeaderDrawer> {
  dynamic data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
      color: kPrimaryColor,
      child: InkWell(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
        onTap: data != null ? () {} : null,
        child: Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.only(top: 20),
          child: data != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
