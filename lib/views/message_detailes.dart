import 'package:flutter/material.dart';

class MessageDetailsScreen extends StatefulWidget {
  static const id = '/messageDetailsScreen';

  const MessageDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Container(),
    );
  }
}
