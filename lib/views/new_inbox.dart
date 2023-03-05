import 'package:complaints/components/date_picker.dart';
import 'package:complaints/views/category.dart';
import 'package:flutter/material.dart';

import '../components/rounded_container.dart';

class NewInbox extends StatefulWidget {
  const NewInbox({Key? key}) : super(key: key);

  @override
  State<NewInbox> createState() => _NewInboxState();
}

class _NewInboxState extends State<NewInbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: const Text('New Inbox'),
        centerTitle: true,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Center(
              child: Text(
            'Cancel',
            style: TextStyle(color: Colors.blue, fontSize: 18),
          )),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Center(
                child: Text(
              'Done',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RoundedContainer(
                  child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                      suffixIcon: const Icon(
                        Icons.info_outline_rounded,
                        color: Colors.blue,
                      ),
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      hintText: 'Sender',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      showModalBottomSheet(
                          clipBehavior: Clip.hardEdge,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return const FractionallySizedBox(
                              heightFactor: 0.92,
                              child: CategoryScreen(),
                            );
                          });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text('other'),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
              RoundedContainer(
                  child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 22, color: Colors.grey.shade400),
                      hintText: 'Title of mail',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                  const Divider(),
                  TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      hintText: 'Description',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  )
                ],
              )),
              RoundedContainer(
                  child: Column(
                children: [
                  CustomDatePicker(controller: TextEditingController()),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.folder_zip_outlined),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Archive Number'),
                          Text('2022/1565'),
                        ],
                      )
                    ],
                  ),
                ],
              )),
              RoundedContainer(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.tag,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'Tags',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade600,
                  ),
                ],
              )),
              RoundedContainer(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.new_label_outlined,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Chip(
                        label: Text(
                          'Pending',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.amber,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade600,
                  ),
                ],
              )),
              RoundedContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Decision',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      hintText: 'Add Decision...',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  )
                ],
              )),
              GestureDetector(
                onTap: () {
                  print('hi');
                },
                child: RoundedContainer(
                    child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    'Add Image',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
