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
    if (data != null) {
      return Material(
        color: Colors.red,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(data['data']['image']),
                      )),
                ),
                Text(
                  data['data']['name'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  data['data']['notify_email'],
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Material(
          color: Colors.red,
          child: Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.only(top: 20),
              child: Center(child: CircularProgressIndicator())));
    }
  }
}
