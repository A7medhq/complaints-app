import 'package:complaints/components/rounded_container.dart';
import 'package:flutter/material.dart';

import '../components/custom_radio_list_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int val = 0;

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
              Navigator.pop(context);
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyRadioListTile(
                value: 1,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value!;
                  });
                },
                title: Text('Official Organization'),
              ),
              Divider(),
              MyRadioListTile(
                value: 2,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value!;
                  });
                },
                title: Text('NGOs'),
              ),
              Divider(),
              MyRadioListTile(
                value: 3,
                groupValue: val,
                onChanged: (value) {
                  setState(() {
                    val = value!;
                  });
                },
                title: Text('Other'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
