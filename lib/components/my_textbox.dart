import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      this.onPressed});

  final String text, sectionName;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName, style: TextStyle(color: Colors.grey.shade500)),
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey.shade400,
                ),
                onPressed: onPressed,
              )
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}
