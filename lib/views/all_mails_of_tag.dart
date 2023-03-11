import 'package:flutter/material.dart';

import '../components/custom_expansion_tile/tile_content.dart';
import '../components/rounded_container.dart';

class AllMailsOfTagScreen extends StatefulWidget {
  static const id = '/allMailsOfTag';

  const AllMailsOfTagScreen({Key? key}) : super(key: key);

  @override
  State<AllMailsOfTagScreen> createState() => _AllMailsOfTagScreenState();
}

class _AllMailsOfTagScreenState extends State<AllMailsOfTagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mails by Tags'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return RoundedContainer(
                child: TileContent(
              color: 0xff00000,
              title: 'Organization Name',
              date: 'Today, 11:00 AM',
              subject: 'Here we add the subject',
              description:
                  'Here we add the subject Here we add the subject Here we add the subject Here we add the subject Here we add the subject',
              tags: '#Urgent #new',
              photosList: Container(),
            ));
          },
        ),
      ),
    );
  }
}
