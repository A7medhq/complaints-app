import 'package:flutter/material.dart';

class TileContent extends StatelessWidget {
  const TileContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 22, left: 11),
          child: Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              radius: 6,
              backgroundColor: Colors.red,
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
                  const Text(
                    'Organization Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    'Today, 11:00 AM',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade500,
                    size: 22,
                  )
                ],
              ),
              const Text(
                'Here we add the subject',
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                'Here we add the subject And here excerpt of the mail, can added to this location. And we can do more to this like ',
                style: TextStyle(fontSize: 12, color: Colors.blue),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                '#Urgent #Egyptian Military',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blue),
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                      height: 32,
                      width: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                      height: 32,
                      width: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png',
                      height: 32,
                      width: 32,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
