import 'package:flutter/material.dart';

class TileContent extends StatelessWidget {
  final String title;
  final String date;
  final String subject;
  final String? description;
  final String tags;
  final int color;
  final Widget photosList;

  const TileContent({
    super.key,
    required this.title,
    required this.date,
    required this.subject,
    this.description,
    required this.tags,
    required this.color,
    required this.photosList,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 22, left: 11),
          child: Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: Color(color),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            fontSize: 10, color: Colors.grey.shade500),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey.shade500,
                        size: 22,
                      )
                    ],
                  )
                ],
              ),
              Text(
                subject,
                style: TextStyle(fontSize: 12),
              ),
              if (description != null)
                Text(
                  description!,
                  style: TextStyle(fontSize: 12, color: Colors.blue),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(
                height: 14,
              ),
              Text(
                tags,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 14,
              ),
              photosList
            ],
          ),
        ),
      ],
    );
  }
}
