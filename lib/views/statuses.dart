import 'package:complaints/providers/statuses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_radio_list_tile.dart';
import '../components/rounded_container.dart';

class StatusesScreen extends StatefulWidget {
  static const id = '/statuses';

  final ScrollController controller;
  const StatusesScreen(this.controller, {Key? key}) : super(key: key);

  @override
  State<StatusesScreen> createState() => _StatusesScreenState();
}

class _StatusesScreenState extends State<StatusesScreen> {
  int val = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: const Text('Choose Status'),
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
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: RoundedContainer(
                child: Consumer<StatusesProvider>(
                  builder: (context, value, child) => ListView.separated(
                      controller: widget.controller,
                      shrinkWrap: true,
                      itemCount: value.statuses!.length,
                      itemBuilder: (context, index) {
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
                          return MyRadioListTile(
                            value: statuses[index].id,
                            groupValue: val,
                            onChanged: (value) {
                              setState(() {
                                val = value!;
                              });
                            },
                            title: Text(statuses[index].name),
                            color: Color(int.parse(statuses[index].color)),
                          );
                        }
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
