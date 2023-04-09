import 'package:firebase_manual/logic/auth.dart';
import 'package:firebase_manual/screens/home_screen.dart';
import 'package:firebase_manual/screens/widgets/button.dart';
import 'package:flutter/material.dart';

import '../utils/snackbar.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  // final _formKey = GlobalKey<FormState>();
  //textformfield controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //Firebase Auth Class
  Auth auth = Auth();

  //Toggle Loading indicator
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 75),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Firebase Setup',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Firebase manual Authentication and Storage',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                hintText: "Email Address",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelText: 'Password',
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          const SizedBox(height: 15),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : const Text(""),
          const SizedBox(height: 15),
          button(
            context: context,
            text: "Sign In",
            width: MediaQuery.of(context).size.height * 0.6,
            height: 50,
            buttonColor: Colors.orange,
            onPressed: () async {
              if (emailController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                showMessage(
                  message: 'Please fill all the fields for login',
                  context: context,
                );
              } else {
                //Triggering loading indicator
                setState(() {
                  isLoading = true;
                });
                //Login the user in Firebase
                await auth.signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                //Navigate to the HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
                setState(() {
                  isLoading = false;
                });
              }
            },
          ),
          const SizedBox(height: 15),
          button(
            context: context,
            width: MediaQuery.of(context).size.height * 0.6,
            height: 50,
            text: "Register",
            buttonColor: Colors.blue,
            onPressed: () async {
              if (emailController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                showMessage(
                  message: 'Please fill all the fields for login',
                  context: context,
                );
              } else {
                //Triggering loading indicator
                setState(() {
                  isLoading = true;
                });
                //Login the user in Firebase
                await auth.register(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                //Navigate to the HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
                setState(() {
                  isLoading = false;
                });
              }
            },
          )
        ],
      ),
    ));
  }
}
