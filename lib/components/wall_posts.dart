import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/comment.dart';
import 'package:social_media_app/components/comment_button.dart';
import 'package:social_media_app/components/delete_button.dart';
import 'package:social_media_app/components/like_button.dart';
import 'package:social_media_app/helper/helper_method.dart';

class WallPost extends StatefulWidget {
  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postID,
    required this.likes,
    required this.time,
  });

  final String message, user, postID, time;
  final List<String> likes;

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  final _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  // Like Toggle
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //Acces the documents is firebase

    DocumentReference postref =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postID);

    if (isLiked) {
      // Post beğenildiğinde database e yansımasını sağlar
      postref.update({
        "Likes": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      // Beğenmekten vazgeçince databaseden silmeye yarar
      postref.update({
        "Likes": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  // Add a comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postID)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  // Show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: _commentController,
          decoration: const InputDecoration(hintText: "Write Comment . ."),
        ),
        actions: [
          // Save button
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
              _commentController.clear();
            },
          ),

          // Cancel button
          TextButton(
            child: const Text("Post"),
            onPressed: () {
              addComment(_commentController.text);
              Navigator.pop(context);
              _commentController.clear();
            },
          ),
        ],
      ),
    );
  }

  // Delete Post
  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Post"),
        content: const Text("Are you sure want to delete this post?"),
        actions: [
          // Cancel button
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.pop(context);
              _commentController.clear();
            },
          ),

          // Delete button
          TextButton(
            child: const Text("Delete"),
            onPressed: () async {
              // Delete Post Comments
              final commentsDocs = await FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postID)
                  .collection("Comments")
                  .get();

              for (var doc in commentsDocs.docs) {
                await FirebaseFirestore.instance
                    .collection("User Post")
                    .doc(widget.postID)
                    .collection("Comments")
                    .doc(doc.id)
                    .delete();
              }

              //Delete Post
              FirebaseFirestore.instance
                  .collection("User Posts")
                  .doc(widget.postID)
                  .delete()
                  .then((value) => print("Post Deleted"))
                  .catchError(
                      (error) => print("Failed to Delete Post : $error"));

              Navigator.pop(context);
              _commentController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WallPost

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Message

                  Text(widget.message),

                  const SizedBox(height: 5),

                  // User

                  Text(
                    widget.user,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  Text(
                    " - ",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                  Text(
                    widget.time,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
              if (widget.user == currentUser.email)
                DeleteButton(
                  onTap: deletePost,
                )
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Like Button
              Column(
                children: [
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                children: [
                  CommentButton(
                    onTap: showCommentDialog,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "0",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postID)
                .collection("Comments")
                .orderBy("CommentTime", descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  // Get the Comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  // Return the comment
                  return Comment(
                    text: commentData["CommentText"],
                    user: commentData["CommentedBy"],
                    time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
