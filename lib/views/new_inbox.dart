import 'package:complaints/components/date_picker.dart';
import 'package:complaints/services/create_message.dart';
import 'package:complaints/views/statuses.dart';
import 'package:complaints/views/tags.dart';
import 'package:flutter/material.dart';

import '../components/rounded_container.dart';
import 'category.dart';

class NewInbox extends StatefulWidget {
  const NewInbox({Key? key}) : super(key: key);

  @override
  State<NewInbox> createState() => _NewInboxState();
}

class _NewInboxState extends State<NewInbox> {
  List<Tag?> _selectedTags = [];

  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController senderIdController = TextEditingController();
  TextEditingController archiveNumberController =
      TextEditingController(text: '2022');
  TextEditingController archiveDateController =
      TextEditingController(text: DateTime.now().toString());
  TextEditingController decisionController = TextEditingController();
  TextEditingController finalDecisionController = TextEditingController();
  TextEditingController activitiesController = TextEditingController();
  String? categoryId;
  String? statusId;

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
              Mails.createNewMail(
                      subject: subjectController.text,
                      description: descriptionController.text,
                      senderId: senderIdController.text,
                      archiveNumber: archiveNumberController.text,
                      archiveDate: archiveDateController.text,
                      decision: decisionController.text,
                      statusId: statusId.toString(),
                      finalDecision: finalDecisionController.text,
                      tags: _selectedTags.map((e) => e!.id).toList().toString(),
                      activities: activitiesController.text)
                  .then((value) {
                if (value.message == 'success') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Done')));
                  print(value.data.mail.id);
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Failed')));
                }
              });
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
                    controller: senderIdController,
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
                              heightFactor: 0.90,
                              child: CategoryScreen(),
                            );
                          }).then((value) {
                        setState(() {
                          categoryId = value;
                        });
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            const Text('other'),
                            const SizedBox(
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
                    controller: subjectController,
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
                    controller: descriptionController,
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
                  CustomDatePicker(controller: archiveDateController),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.folder_zip_outlined),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Archive Number'),
                          const Text('2022/1565'),
                        ],
                      )
                    ],
                  ),
                ],
              )),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      clipBehavior: Clip.hardEdge,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const FractionallySizedBox(
                          heightFactor: 0.90,
                          child: TagsScreen(),
                        );
                      }).then((value) {
                    setState(() {
                      _selectedTags = value;
                      print(_selectedTags);
                    });
                  });
                },
                child: RoundedContainer(
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
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      clipBehavior: Clip.hardEdge,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const FractionallySizedBox(
                          heightFactor: 0.90,
                          child: StatusesScreen(),
                        );
                      }).then((value) {
                    setState(() {
                      statusId = value.toString();
                    });
                  });
                },
                child: RoundedContainer(
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
                          label: const Text(
                            'Pending',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.amber,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey.shade600,
                    ),
                  ],
                )),
              ),
              RoundedContainer(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Decision',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextField(
                    controller: decisionController,
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
