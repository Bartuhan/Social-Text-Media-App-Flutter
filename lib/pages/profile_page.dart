import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_textbox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  //editField
  Future<void> editField(String field) async {
    //edit
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter The New $field",
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // Cancel button
          TextButton(
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.pop(context),
          ),

          // Save button
          TextButton(
            child: const Text("Save", style: TextStyle(color: Colors.white)),
            onPressed: () => Navigator.of(context).pop(newValue),
          )
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Profile Page"),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    const SizedBox(height: 50),
                    // Profile Pic
                    const Icon(
                      Icons.person,
                      size: 72,
                    ),

                    const SizedBox(height: 10),

                    // User Email
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 50),

                    // User Details
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "MyDetails",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),

                    // UserName
                    MyTextBox(
                      text: userData["username"],
                      sectionName: "User Name",
                      onPressed: () => editField("username"),
                    ),

                    // Bio
                    MyTextBox(
                      text: userData["bio"],
                      sectionName: "Bio",
                      onPressed: () => editField("bio"),
                    ),
                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "MyPosts",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),

                    // UserPosts
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.hasError}"),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

// ListView(
//         children: [
//           const SizedBox(height: 50),
//           // Profile Pic
//           const Icon(
//             Icons.person,
//             size: 72,
//           ),

//           const SizedBox(height: 10),

//           // User Email
//           Text(
//             currentUser.email!,
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey.shade700),
//           ),
//           const SizedBox(height: 50),

//           // User Details
//           Padding(
//             padding: const EdgeInsets.only(left: 25.0),
//             child: Text(
//               "MyDetails",
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//           ),

//           // UserName
//           MyTextBox(
//             text: "Bartuhan",
//             sectionName: "User Name",
//             onPressed: () => editField("User Name"),
//           ),

//           // Bio
//           MyTextBox(
//             text: "Empty Bio",
//             sectionName: "Bio",
//             onPressed: () => editField("Bio"),
//           ),
//           const SizedBox(height: 15),

//           Padding(
//             padding: const EdgeInsets.only(left: 25.0),
//             child: Text(
//               "MyPosts",
//               style: TextStyle(color: Colors.grey.shade700),
//             ),
//           ),

//           // UserPosts
//         ],
//       ),
