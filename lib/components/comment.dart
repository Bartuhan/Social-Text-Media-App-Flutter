import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment(
      {super.key, required this.text, required this.user, required this.time});

  final String text, user, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comment
          Text(text),
          const SizedBox(width: 5),

          // User
          Row(
            children: [
              Text(
                user,
                style: TextStyle(color: Colors.grey.shade400),
              ),
              Text(
                " - ",
                style: TextStyle(color: Colors.grey.shade400),
              ),
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade400),
              ),
            ],
          )
        ],
      ),
    );
  }
}
