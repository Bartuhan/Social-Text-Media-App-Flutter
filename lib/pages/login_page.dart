import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/button.dart';

import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      //Create New User

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

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
                  "Welcome back you've been missed!",
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

                // SignIn Button
                const SizedBox(height: 20),

                MyButton(
                  onTap: signIn,
                  text: "Sign In",
                ),
                const SizedBox(height: 20),

                // RegisterPage'e gitme
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register now",
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
