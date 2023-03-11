import 'package:complaints/components/rounded_container.dart';
import 'package:complaints/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_radio_list_tile.dart';

class CategoryScreen extends StatefulWidget {
  final ScrollController controller;
  const CategoryScreen(this.controller, {Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int val = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: const Text('Category'),
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
              Navigator.pop(context, val);
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
        child: RoundedContainer(
          child: Consumer<CategoriesProvider>(
            builder: (context, value, child) => ListView.separated(
                controller: widget.controller,
                itemCount: value.categories!.length,
                itemBuilder: (context, index) {
                  if (value.state == CategoriesState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (value.state == CategoriesState.Error) {
                    return Center(
                      child: Text('Error'),
                    );
                  }

                  final categories = value.categories;
                  if (categories != null &&
                      value.state == CategoriesState.Loaded) {
                    return MyRadioListTile(
                      value: categories[index].id,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      title: Text(categories[index].name!),
                    );
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider()),
          ),
        ),
      ),
    );
  }
}
