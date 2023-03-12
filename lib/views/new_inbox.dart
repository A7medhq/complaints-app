import 'dart:io';

import 'package:complaints/providers/statuses_provider.dart';
import 'package:complaints/providers/tags_provider.dart';
import 'package:complaints/services/create_message.dart';
import 'package:complaints/views/category.dart';
import 'package:complaints/views/statuses.dart';
import 'package:complaints/views/tags.dart' as TagsScreen;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/rounded_container.dart';
import '../models/all_statuses.dart';

class NewInbox extends StatefulWidget {
  final ScrollController controller;
  const NewInbox(this.controller, {Key? key}) : super(key: key);

  @override
  State<NewInbox> createState() => _NewInboxState();
}

class _NewInboxState extends State<NewInbox> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;

  List<TagsScreen.Tag?> _selectedTags = [];
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController senderIdController = TextEditingController();
  TextEditingController archiveNumberController =
      TextEditingController(text: '2022');
  DateTime archiveDate = DateTime.now();
  TextEditingController decisionController = TextEditingController();
  TextEditingController finalDecisionController = TextEditingController();
  TextEditingController activitiesController = TextEditingController();
  String? categoryId;
  String? statusId;

  Future<List<XFile>?> pickImage() async {
    images = await _picker.pickMultiImage();
    print(images);
    return images;
  }

  Future<dynamic> _showCategoryBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.92,
                maxChildSize: 0.92,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: CategoryScreen(controller));
                },
              ),
            ),
          ),
        );
      },
    ).then((value) => value);
  }

  Future<dynamic> _showTagBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.92,
                maxChildSize: 0.92,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: TagsScreen.TagsScreen(controller));
                },
              ),
            ),
          ),
        );
      },
    ).then((value) => value);
  }

  Future<dynamic> _showStatusBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.92,
                maxChildSize: 0.92,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: StatusesScreen(controller));
                },
              ),
            ),
          ),
        );
      },
    ).then((value) => value);
  }

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
                      archiveDate: archiveDate.toString(),
                      decision: decisionController.text,
                      statusId: statusId.toString(),
                      finalDecision: finalDecisionController.text,
                      tags: _selectedTags.map((e) => e!.id).toList().toString(),
                      activities: activitiesController.text)
                  .then((value) {
                if (value.message == 'success') {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Email Created')));
                  if (images != null) {
                    Mails.addAttachments(
                            mailId: value.data.mail.id.toString(),
                            images: images)
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text('Attachments Uploaded'))));
                  }
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
          controller: widget.controller,
          child: Column(
            children: [
              RoundedContainer(
                  mail: null,
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
                          _showCategoryBottomSheet(context).then((value) {
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
                  mail: null,
                  child: Column(
                    children: [
                      TextField(
                        controller: subjectController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 22, color: Colors.grey.shade400),
                          hintText: 'Title of mail',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      const Divider(),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                          hintText: 'Description',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )
                    ],
                  )),
              RoundedContainer(
                  mail: null,
                  child: Column(
                    children: [
                      Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(vertical: 0),
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.red,
                          ),
                          title: Text('Date'),
                          subtitle: Text(
                            DateFormat('EEEE, MMMM d, yyyy')
                                .format(archiveDate),
                            style: TextStyle(color: Colors.blue),
                          ),
                          children: [
                            CalendarDatePicker(
                              initialDate: archiveDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2025),
                              onDateChanged: (DateTime value) {
                                archiveDate = value;
                                setState(() {});
                                print(archiveDate);
                              },
                            ),
                          ],
                        ),
                      ),
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
                  _showTagBottomSheet(context).then((value) {
                    if (value != null) {
                      setState(() {
                        _selectedTags = value;
                      });
                    }
                  });
                },
                child: RoundedContainer(
                    mail: null,
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
                            _selectedTags.isEmpty
                                ? Text('Select Tags')
                                : SizedBox(
                                    width: 200,
                                    child: Consumer<TagsProvider>(
                                      builder: (context, value, child) {
                                        if (value.state == TagsState.Loading) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (value.state == TagsState.Error) {
                                          return Center(
                                            child: Text('Error'),
                                          );
                                        }
                                        final tags = value.tags;
                                        if (value.state == TagsState.Loaded &&
                                            tags != null) {
                                          dynamic result = [];

                                          for (var selItem in _selectedTags) {
                                            final filtered = tags
                                                .where((tag) =>
                                                    tag.id == selItem!.id)
                                                .toList();
                                            if (filtered.isEmpty) {
                                              result.add(selItem);
                                            } else {
                                              result.addAll(filtered);
                                            }
                                          }

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                for (var tag in result) ...[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Chip(
                                                      label: Text(
                                                        '#${tag!.name}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey.shade800),
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30)),
                                                      backgroundColor:
                                                          Colors.grey.shade300,
                                                      side: BorderSide.none,
                                                    ),
                                                  )
                                                ]
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Text(
                                              'error fetching selected tags');
                                        }
                                      },
                                    ),
                                  )
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
                  _showStatusBottomSheet(context).then((value) {
                    if (value != null) {
                      setState(() {
                        statusId = value.toString();
                      });
                    }
                  });
                },
                child: RoundedContainer(
                    mail: null,
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
                            statusId == null
                                ? Text('Select a status')
                                : Consumer<StatusesProvider>(
                                    builder: (context, value, child) {
                                    if (value.state == StatusesState.Loading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (value.state == StatusesState.Error) {
                                      return Center(
                                        child: Text('Error'),
                                      );
                                    }
                                    final statuses = value.statuses;
                                    if (value.state == StatusesState.Loaded &&
                                        statuses != null) {
                                      Status? status;

                                      if (statusId != null) {
                                        status = statuses
                                            .where((element) =>
                                                element.id ==
                                                int.parse(statusId!))
                                            .first;
                                      }

                                      return Chip(
                                        label: Text(
                                          status!.name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor:
                                            Color(int.parse(status.color)),
                                        side: BorderSide.none,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                      );
                                    } else {
                                      return Text(
                                          'error fetching selected tags');
                                    }
                                  })
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
                  mail: null,
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
                          hintStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                          hintText: 'Add Decision...',
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      )
                    ],
                  )),
              if (images != null) ...[
                if (images!.isNotEmpty) ...[
                  RoundedContainer(
                      mail: null,
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 50,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: images!.length,
                                    itemBuilder: (context, index) => Row(
                                          children: [
                                            GestureDetector(
                                              onLongPress: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          content: Text(
                                                              'Remove Image?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  images!
                                                                      .removeAt(
                                                                          index);
                                                                  setState(
                                                                      () {});
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  'REMOVE',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ))
                                                          ],
                                                        ));
                                              },
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    clipBehavior: Clip.hardEdge,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Hero(
                                                      tag: 'image$index',
                                                      child: Image.file(
                                                        File(images![index]
                                                            .path),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Hero(
                                                  tag: 'image$index',
                                                  child: Image.file(
                                                    File(images![index].path),
                                                    height: 40,
                                                    width: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 14,
                                            )
                                          ],
                                        )),
                              ),
                            ],
                          ))),
                ],
              ],
              GestureDetector(
                onTap: () {
                  pickImage().then((value) => setState(() {}));
                },
                child: RoundedContainer(
                    mail: null,
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
