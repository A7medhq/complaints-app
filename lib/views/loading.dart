import 'package:complaints/views/auth.dart';
import 'package:flutter/material.dart';

import 'main_layout.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String currentPage = 'auth';

  @override
  Widget build(BuildContext context) {
    if (currentPage == 'main') {
      return const MainLayout();
    } else {
      return const AuthScreen();
    }
  }
}
