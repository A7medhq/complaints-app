import 'package:complaints/services/tag_services.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/tags_provider.dart';

class TagsScreen extends StatefulWidget {
  static const id = '/tags';

  const TagsScreen({Key? key}) : super(key: key);

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class Tag {
  final int id;
  final String name;

  Tag({
    required this.id,
    required this.name,
  });
}

class _TagsScreenState extends State<TagsScreen> {
  List<Tag?> _selectedTags = [];
  TextEditingController tagNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: const Text('Tags'),
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
              Navigator.pop(context, _selectedTags);
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
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28)),
                child: Column(
                  children: [
                    Consumer<TagsProvider>(builder: (context, value, child) {
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
                      return MultiSelectChipField(
                        headerColor: Colors.transparent,
                        scroll: false,
                        searchable: true,
                        decoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none)),
                        items: [
                          if (tags != null)
                            for (var i = 0; i < tags.length; i++) ...[
                              Tag(id: tags[i].id, name: tags[i].name),
                            ]
                        ]
                            .map((tag) =>
                                MultiSelectItem<Tag?>(tag, '#${tag.name}'))
                            .toList(),
                        // listType: MultiSelectListType.CHIP,
                        onTap: (value) {
                          _selectedTags = value;
                        },
                        // buttonIcon: Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 16,
                        // ),
                      );
                    }),
                    SizedBox(
                      height: 36,
                    ),
                    TextField(
                      controller: tagNameController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              await TagsServices.createTags(
                                      tagNameController.text)
                                  .then((value) {
                                if (value != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value.message)));
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('failed')));
                                }
                                Provider.of<TagsProvider>(context,
                                        listen: false)
                                    .getTags();
                              });
                            },
                            icon: Icon(Icons.save)),
                        labelText: 'Add New Tag',
                        hintText: 'Tag Name',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
