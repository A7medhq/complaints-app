import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/rounded_container.dart';

class MessageDetailsScreen extends StatefulWidget {
  static const id = '/messageDetailsScreen';
  final dynamic mail;

  const MessageDetailsScreen({Key? key, required this.mail}) : super(key: key);

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: const Text('Message Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RoundedContainer(
                  mail: null,
                  child: Column(
                    children: [
                      TextField(
                        controller:
                            TextEditingController(text: widget.mail.senderId),
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Sender Id',
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                          suffixIcon: const Icon(
                            Icons.info_outline_rounded,
                            color: Colors.blue,
                          ),
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          hintText: 'Sender',
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.mail.sender.category.name,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  )),
              RoundedContainer(
                  mail: null,
                  child: Column(
                    children: [
                      TextField(
                        controller:
                            TextEditingController(text: widget.mail.subject),
                        enabled: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 22, color: Colors.grey.shade400),
                          hintText: 'Title of mail',
                          labelText: 'Title',
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      const Divider(),
                      TextField(
                        controller: TextEditingController(
                            text: widget.mail.description),
                        enabled: false,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 14, color: Colors.grey.shade400),
                          hintText: 'Description',
                          labelText: 'Description',
                          disabledBorder: InputBorder.none,
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
                                .format(widget.mail.archiveDate),
                            style: TextStyle(color: Colors.blue),
                          ),
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
                              Text('${widget.mail.archiveNumber}'),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
              RoundedContainer(
                  mail: null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 230,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Icon(
                                Icons.tag,
                                color: Colors.grey.shade600,
                              ),
                              for (var tag in widget.mail.tags) ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Chip(
                                    label: Text(
                                      '#${tag!.name}',
                                      style: TextStyle(
                                          color: Colors.grey.shade800),
                                    ),
                                  ),
                                )
                              ],
                              SizedBox(
                                width: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              RoundedContainer(
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
                          Chip(
                            label: Text(
                              widget.mail.status.name,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                Color(int.parse(widget.mail.status.color)),
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                          )
                        ],
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  )),
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
                        controller:
                            TextEditingController(text: widget.mail.decision),
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
              if (widget.mail.attachments != null) ...[
                if (widget.mail.attachments!.isNotEmpty) ...[
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
                                    itemCount: widget.mail.attachments!.length,
                                    itemBuilder: (context, index) => Row(
                                          children: [
                                            GestureDetector(
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
                                                      child: Image.network(
                                                        'https://palmail.betweenltd.com/storage/${widget.mail.attachments[index].image}',
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
                                                  child: Image.network(
                                                    'https://palmail.betweenltd.com/storage/${widget.mail.attachments[index].image}',
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
            ],
          ),
        ),
      ),
    );
  }
}
