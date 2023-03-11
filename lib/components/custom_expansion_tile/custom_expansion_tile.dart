import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  String name;
  Widget child;
  String count;
  CustomExpansionTile(
      {Key? key, required this.name, required this.child, required this.count})
      : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(vertical: 4),
        title: Text(
          widget.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.count,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey.shade400),
            ),
            Icon(
              _customTileExpanded
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              color: _customTileExpanded ? Colors.blue : Colors.grey.shade400,
            ),
          ],
        ),
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),
              child: widget.child)
        ],
        onExpansionChanged: (bool expanded) {
          setState(() => _customTileExpanded = expanded);
        },
      ),
    );
  }
}
