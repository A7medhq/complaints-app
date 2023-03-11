import 'package:complaints/providers/statuses_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/custom_expansion_tile/tile_content.dart';
import '../components/rounded_container.dart';

class AllMailsOfStatusScreen extends StatefulWidget {
  static const id = '/allMailsOfStatus';
  int? statusId;

  AllMailsOfStatusScreen({Key? key, required this.statusId}) : super(key: key);

  @override
  State<AllMailsOfStatusScreen> createState() => _AllMailsOfStatusScreenState();
}

class _AllMailsOfStatusScreenState extends State<AllMailsOfStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mails by Status'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<StatusesProvider>(builder: (context, value, child) {
          if (value.state == StatusesState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (value.state == StatusesState.Error) {
            return Text('error occurd');
          }

          final statuses = value.statuses;

          if (statuses != null && value.state == StatusesState.Loaded) {
            print(statuses
                .where((element) => element.id == widget.statusId)
                .toList()
                .first
                .mails
                .length);
            return ListView.builder(
              itemCount: statuses
                  .where((element) => element.id == widget.statusId)
                  .toList()
                  .first
                  .mails
                  .length,
              itemBuilder: (BuildContext context, int index) {
                return RoundedContainer(
                    child: TileContent(
                  color: int.parse(statuses
                      .where((element) => element.id == widget.statusId)
                      .toList()
                      .first
                      .color),
                  title: statuses
                      .where((element) => element.id == widget.statusId)
                      .toList()
                      .first
                      .mails[index]
                      .sender
                      .name,
                  date: DateFormat('EEEE, HH:MM').format(statuses
                      .where((element) => element.id == widget.statusId)
                      .toList()
                      .first
                      .mails[index]
                      .createdAt),
                  subject: statuses
                      .where((element) => element.id == widget.statusId)
                      .toList()
                      .first
                      .mails[index]
                      .subject,
                  description: statuses
                      .where((element) => element.id == widget.statusId)
                      .toList()
                      .first
                      .mails[index]
                      .description,
                  tags: statuses
                      .where((element) => element.id == widget.statusId)
                      .toList()
                      .first
                      .mails[index]
                      .tags
                      .map((e) => '#${e.name}   ')
                      .toList()
                      .join()
                      .toString(),
                  photosList: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: statuses
                            .where((element) => element.id == widget.statusId)
                            .toList()
                            .first
                            .mails[index]
                            .attachments
                            .length,
                        itemBuilder: (context, attachmentsIndex) => Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        clipBehavior: Clip.hardEdge,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        contentPadding: EdgeInsets.zero,
                                        content: Hero(
                                          tag: 'image$attachmentsIndex',
                                          child: Image.network(
                                            'https://palmail.betweenltd.com/storage/${statuses.where((element) => element.id == widget.statusId).toList().first.mails[index].attachments.map((e) => e.image).toList()[attachmentsIndex]}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Hero(
                                      tag: 'image$attachmentsIndex',
                                      child: Image.network(
                                        'https://palmail.betweenltd.com/storage/${statuses.where((element) => element.id == widget.statusId).toList().first.mails[index].attachments.map((e) => e.image).toList()[attachmentsIndex]}',
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
                ));
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
