import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/pages/home_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, this.onProfileTap, this.onSignOut});

  final void Function()? onProfileTap;
  final void Function()? onSignOut;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade900,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // Header
              const DrawerHeader(
                  child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              )),

              // Home ListTile
              MyListTile(
                icon: Icons.home,
                text: "H O M E",
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
              ),

              // Profile ListTile
              MyListTile(
                icon: Icons.person,
                text: "P R O F İ L E",
                onTap: onProfileTap,
              ),
            ],
          ),

          // LogOut ListTile
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
              icon: Icons.logout,
              text: "L O G O U T",
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
