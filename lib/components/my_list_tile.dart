import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key, required this.icon, required this.text, this.onTap});

  final IconData icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(text, style: const TextStyle(color: Colors.white)),
        onTap: onTap,
      ),
    );
  }
}