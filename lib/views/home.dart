import 'package:complaints/components/custom_action_chip.dart';
import 'package:complaints/components/custom_expansion_tile/tile_content.dart';
import 'package:complaints/providers/categories_provider.dart';
import 'package:complaints/providers/statuses_provider.dart';
import 'package:complaints/providers/tags_provider.dart';
import 'package:complaints/views/new_inbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../components/custom_expansion_tile/custom_expansion_tile.dart';

class HomeScreen extends StatelessWidget {
  static const id = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

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
                    final statuses = value.statuses;

                    if (statuses != null) {
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
                          return CategoryCard(
                            categoryName: statuses[index].name,
                            messagesCount:
                                int.parse(statuses[index].mailsCount),
                            tagColor: Color(int.parse(statuses[index].color)),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                Consumer<CategoriesProvider>(builder: (context, value, child) {
                  final categories = value.categories;
                  if (categories != null) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) => CustomExpansionTile(
                            name: categories[index].name!,
                            tilesList: [TileContent()]));
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
      bottomNavigationBar: InkWell(
        onTap: () {
          showModalBottomSheet(
              clipBehavior: Clip.hardEdge,
              context: context,
              isScrollControlled: true,
              builder: (context) {
                return const FractionallySizedBox(
                  heightFactor: 0.92,
                  child: NewInbox(),
                );
              });
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
