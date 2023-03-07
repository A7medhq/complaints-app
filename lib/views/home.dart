import 'package:complaints/components/custom_expansion_tile/tile_content.dart';
import 'package:complaints/services/create_tags.dart';
import 'package:complaints/views/new_inbox.dart';
import 'package:flutter/material.dart';

import '../components/category_card.dart';
import '../components/custom_expansion_tile/custom_expansion_tile.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/homeScreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    createTags("wesam");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 5 / 3,
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  children: [
                    CategoryCard(
                      categoryName: 'Inbox',
                      messagesCount: 9,
                      tagColor: Colors.red,
                    ),
                    CategoryCard(
                      categoryName: 'Inbox',
                      messagesCount: 9,
                      tagColor: Colors.yellow,
                    ),
                    CategoryCard(
                      categoryName: 'Inbox',
                      messagesCount: 12,
                      tagColor: Colors.green,
                    ),
                    CategoryCard(
                      categoryName: 'Inbox',
                      messagesCount: 1,
                      tagColor: Colors.blue,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomExpansionTile(
                name: 'NGOs',
                tilesList: const [TileContent(), TileContent()],
              ),
              CustomExpansionTile(
                name: 'Organization Name',
                tilesList: const [TileContent()],
              ),
              CustomExpansionTile(
                name: 'Others',
                tilesList: const [TileContent(), TileContent()],
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Tags',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  )),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28)),
                child: Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text(
                        'All Tags',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    ),
                    Chip(
                      label: Text(
                        '#Working',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    ),
                    Chip(
                      label: Text(
                        '#new',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    ),
                    Chip(
                      label: Text(
                        '#Working',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      backgroundColor: Colors.grey.shade200,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    ),
                  ],
                ),
              )
            ],
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
          padding: EdgeInsets.all(16),
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
