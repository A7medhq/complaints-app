import 'package:complaints/components/custom_expansion_tile/tile_content.dart';
import 'package:flutter/material.dart';

import '../components/category_card.dart';
import '../components/custom_expansion_tile/custom_expansion_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
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
              GridView(
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
            ],
          ),
        ),
      ),
    );
  }
}
