import 'package:flutter/material.dart';

class about_categories extends StatelessWidget {
  const about_categories(
      {super.key, required this.topic, required this.x, this.genre});

  final x, topic, genre;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          topic,
          style: const TextStyle(color: Colors.white60, fontSize: 14),
        ),
        Text(
          "$x",
          style: const TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
