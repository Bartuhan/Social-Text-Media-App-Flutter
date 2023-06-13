import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/drawer.dart';
import 'package:social_media_app/components/my_textfield.dart';
import 'package:social_media_app/helper/helper_method.dart';

import '../components/wall_posts.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  //SignOut User

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  postMessage() {
    //only post if there is something in the textfield

    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        "Message": textController.text,
        "User": currentUser.email,
        "TimeStamp": DateTime.now(),
        "Likes": [],
      });
    }

    //Clear the TextField
    setState(() {
      textController.clear();
    });
  }

  goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfilePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("The Wall"),
        centerTitle: true,
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: () {
          signOut();
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          //The Wall
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy(
                    "TimeStamp",
                    descending: false,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // Get Message
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post["Message"],
                        user: post["User"],
                        postID: post.id,
                        time: formatDate(post["TimeStamp"]),
                        likes: List<String>.from(post["Likes"] ?? []),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Error : ${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),

          //Post Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    emailController: textController,
                    hintText: "Write something on the wall...",
                    obscureText: false,
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(8)),
                  child: IconButton(
                      onPressed: postMessage,
                      icon: const Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
          ),

          //Logged In
          Text(
            "Logged in as : ${currentUser.email}",
            style: TextStyle(color: Colors.grey.shade500),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
