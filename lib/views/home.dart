import 'package:complaints/components/custom_action_chip.dart';
import 'package:complaints/components/custom_expansion_tile/tile_content.dart';
import 'package:complaints/providers/categories_provider.dart';
import 'package:complaints/providers/mails_by_tags_provider.dart';
import 'package:complaints/providers/mails_provider.dart';
import 'package:complaints/providers/statuses_provider.dart';
import 'package:complaints/providers/tags_provider.dart';
import 'package:complaints/views/all_mails_of_status.dart';
import 'package:complaints/views/new_inbox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../components/custom_expansion_tile/custom_expansion_tile.dart';
import '../models/all_mails.dart';
import 'all_mails_of_tag.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
                initialChildSize: 0.94,
                maxChildSize: 0.94,
                builder: (_, controller) {
                  return Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25)),
                      ),
                      child: NewInbox(controller));
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  autofocus: false,
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      prefixIcon: const Icon(Icons.search),
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      hintText: 'Search',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                              const BorderSide(color: Color(0xff3A98B9)))),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Consumer<StatusesProvider>(
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
                      if (statuses != null &&
                          value.state == StatusesState.Loaded) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 5 / 3,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemCount: statuses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllMailsOfStatusScreen(
                                                statusId: statuses[index].id)));
                              },
                              child: CategoryCard(
                                categoryName: statuses[index].name,
                                messagesCount:
                                    int.parse(statuses[index].mailsCount),
                                tagColor:
                                    Color(int.parse(statuses[index].color)),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Consumer2<CategoriesProvider, MailsProvider>(
                    builder: (context, catValue, mailsValue, child) {
                  if (catValue.state == CategoriesState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (catValue.state == CategoriesState.Error) {
                    return Center(
                      child: Text('Error'),
                    );
                  }

                  final categories = catValue.categories;

                  if (categories != null &&
                      catValue.state == CategoriesState.Loaded) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          List<Mail> filteredMails = [];

                          if (mailsValue.state == MailsState.Loaded) {
                            final mails = mailsValue.allMails;
                            filteredMails = mails!.where((e) {
                              return e.sender.category.name ==
                                  categories[index].name;
                            }).toList();

                            return CustomExpansionTile(
                                name: categories[index].name!,
                                count: filteredMails.length.toString(),
                                child: ListView.separated(
                                  itemCount: filteredMails.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TileContent(
                                      color: int.parse(
                                          filteredMails[index].status.color),
                                      title: filteredMails[index]
                                          .sender
                                          .category
                                          .name,
                                      date: DateFormat('EEEE, MMMM d, yyyy')
                                          .format(
                                              filteredMails[index].createdAt),
                                      subject: filteredMails[index].subject,
                                      description:
                                          filteredMails[index].description,
                                      tags: filteredMails[index]
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
                                            itemCount: filteredMails[index]
                                                .attachments
                                                .length,
                                            itemBuilder: (context,
                                                    attachmentsIndex) =>
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            content: Hero(
                                                              tag:
                                                                  'image$attachmentsIndex',
                                                              child:
                                                                  Image.network(
                                                                'https://palmail.betweenltd.com/storage/${filteredMails[index].attachments.map((e) => e.image).toList()[attachmentsIndex]}',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Hero(
                                                          tag:
                                                              'image$attachmentsIndex',
                                                          child: Image.network(
                                                            'https://palmail.betweenltd.com/storage/${filteredMails[index].attachments.map((e) => e.image).toList()[attachmentsIndex]}',
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
                                    );
                                  },
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.grey,
                                  ),
                                ));
                          }
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tags',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    )),
                const SizedBox(
                  height: 16,
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28)),
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
                        return Wrap(
                          spacing: 8,
                          children: [
                            CustomActionChip(
                              title: 'All Tags',
                              onPressed: () {},
                            ),
                            if (tags != null)
                              for (var i = 0; i < tags.length; i++) ...[
                                CustomActionChip(
                                  title: tags[i].name,
                                  onPressed: () {
                                    Provider.of<MailsByTagsProvider>(context,
                                            listen: false)
                                        .getTags(tags: [tags[i].id]);
                                    Navigator.of(context)
                                        .pushNamed(AllMailsOfTagScreen.id);
                                  },
                                )
                              ]
                          ],
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _showBottomSheet(context);
        },
        onVerticalDragStart: (c) {
          _showBottomSheet(context);
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade400))),
          child: Row(
            children: const [
              Icon(Icons.add_circle_rounded, size: 26, color: Colors.blue),
              SizedBox(
                width: 18,
              ),
              Text(
                'New Inbox',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
