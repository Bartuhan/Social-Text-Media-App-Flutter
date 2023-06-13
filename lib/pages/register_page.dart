import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //Make Sure Password
    if (_passwordController.text != _confirmPasswordController.text) {
      //Pop loading circle

      Navigator.pop(context);

      //Show error to User

      displayMessage("Passwords don't match!");
      return;
    }

    try {
      //Create New User

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      //After Creating the user , create a new document in cloud firestore called users
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        "username": _emailController.text.split("@")[0], // initial Username
        "bio": "Empty Bio . . ", // initial Bio
      });

      //pop context
      if (context.mounted) Navigator.pop(context);

      //
    } on FirebaseAuthException catch (e) {
      //pop context
      Navigator.pop(context);

      //show error to user
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                // Karşılama yazısı
                const SizedBox(height: 50),

                Text(
                  "Lets create an account for you!",
                  style: TextStyle(color: Colors.grey.shade700),
                ),

                // Email TextField alanı

                const SizedBox(height: 20),

                MyTextField(
                  emailController: _emailController,
                  obscureText: false,
                  hintText: "Email",
                ),

                const SizedBox(height: 10),

                // Password TextField alanı

                MyTextField(
                  emailController: _passwordController,
                  obscureText: true,
                  hintText: "Password",
                ),
                const SizedBox(height: 10),

                // Confirm Password TextField alanı

                MyTextField(
                  emailController: _confirmPasswordController,
                  obscureText: true,
                  hintText: "Confirm Password",
                ),

                // SignIn Button
                const SizedBox(height: 20),

                MyButton(
                  onTap: signUp,
                  text: "Sign Up",
                ),
                const SizedBox(height: 20),

                // RegisterPage'e gitme
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
