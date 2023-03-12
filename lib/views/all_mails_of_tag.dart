import 'package:complaints/providers/mails_by_tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../components/custom_expansion_tile/tile_content.dart';
import '../components/rounded_container.dart';

class AllMailsOfTagScreen extends StatefulWidget {
  static const id = '/allMailsOfTag';

  const AllMailsOfTagScreen({Key? key}) : super(key: key);

  @override
  State<AllMailsOfTagScreen> createState() => _AllMailsOfTagScreenState();
}

class _AllMailsOfTagScreenState extends State<AllMailsOfTagScreen> {
  Shimmer categoriesShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return RoundedContainer(
                mail: null,
                child: TileContent(
                  color: 0xffff,
                  title: 'mails[index].sender.name',
                  date: '',
                  subject: '',
                  description: 'mails[index].description',
                  tags: '',
                  photosList: SizedBox(
                    height: 50,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, attachmentsIndex) => Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
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
        ));
  }

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
        child: Consumer<MailsByTagsProvider>(builder: (context, value, child) {
          if (value.state == MailsByTagsState.Loading) {
            return categoriesShimmer();
          }
          if (value.state == MailsByTagsState.Error) {
            return categoriesShimmer();
          }

          final mails = value.mails;
          if (mails != null && value.state == MailsByTagsState.Loaded) {
            return ListView.builder(
              itemCount: mails.length,
              itemBuilder: (BuildContext context, int index) {
                return RoundedContainer(
                    mail: mails[index],
                    child: TileContent(
                      color: int.parse(mails[index].status.color),
                      title: mails[index].sender.name,
                      date: DateFormat('EEEE, HH:MM')
                          .format(mails[index].createdAt),
                      subject: mails[index].subject,
                      description: mails[index].description,
                      tags: mails[index]
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
                            itemCount: mails[index].attachments.length,
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
                                                'https://palmail.betweenltd.com/storage/${mails[index].attachments.map((e) => e.image).toList()[attachmentsIndex]}',
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
                                          tag: 'image$attachmentsIndex',
                                          child: Image.network(
                                            'https://palmail.betweenltd.com/storage/${mails[index].attachments.map((e) => e.image).toList()[attachmentsIndex]}',
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
            return categoriesShimmer();
          }
        }),
      ),
    );
  }
}
