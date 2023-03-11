import 'package:flutter/material.dart';

import '../models/AllMailsOfTags.dart';

class MessageDetailsScreen extends StatefulWidget {
  static const id = '/messageDetailsScreen';

  const MessageDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    List<Mail> args = ModalRoute.of(context)!.settings.arguments as List<Mail>;
    print(args.first.subject);
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Container(),
    );
  }
}
