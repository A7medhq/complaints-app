import 'package:complaints/providers/mails_provider.dart';
import 'package:complaints/services/get_current_user.dart';
import 'package:complaints/views/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';
import '../providers/statuses_provider.dart';
import '../providers/tags_provider.dart';
import 'main_layout.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool? status;

  Future<void> getCurrentUser() async {
    status = await CurrentUserService.getCurrentUserInfo();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (status != null) {
      if (status!) {
        Provider.of<MailsProvider>(context, listen: false).getAllMails();
        Provider.of<TagsProvider>(context, listen: false).getTags();
        Provider.of<StatusesProvider>(context, listen: false).getStatuses();
        Provider.of<CategoriesProvider>(context, listen: false).getCategories();
        return const MainLayout();
      } else {
        return const AuthScreen();
      }
    }
    {
      return const Scaffold(
          body: Center(
              child: SpinKitSpinningLines(
        color: Color(0xff4D455D),
        size: 50.0,
      )));
    }
  }
}
