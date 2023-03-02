import 'package:complaints/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
          backgroundColor: Colors.grey.shade200,
          drawer: Drawer(
            child: Column(),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Material(
                    shape: CircleBorder(
                        side: BorderSide(color: Colors.white, width: 3)),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff3A98B9),
                    ),
                  ),
                ),
              )
            ],
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: const HomeScreen()),
    );
  }
}
