import 'package:flutter/material.dart';
import 'package:flutter_auth/constants/colors.dart';
import 'package:flutter_auth/constants/description.dart';
import 'package:flutter_auth/screens/dashboard/bills_page.dart';
import 'package:flutter_auth/screens/home/home.dart';
import 'package:flutter_auth/screens/test_screen.dart';
import '../../constants/styles.dart';
import '../../services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue background for logo and app name
            Container(
              color: Colors.blue, // Blue background color
              child: Column(
                children: [
                  const SizedBox(height: 50), // Spacing
                  // App Name "AquaBill"
                  const Center(
                    child: Text(
                      "AquaBill",
                      style: TextStyle(
                        color: Colors.white, // White color for the text
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Spacing
                  // Description
                  const Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30), // Spacing
                ],
              ),
            ),

            // White background for the rest of the page
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0), // Padding around the content
              child: Column(
                children: [
                  // Screen Name "Sign In"
                  const Text(
                    "SIGN IN",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 20), // Spacing

                  // Center image
                  Center(
                      child: Image.asset(
                    'assets/images/man.png',
                    height: 150,
                  )),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email input field
                          TextFormField(
                            style: const TextStyle(color: Colors.black),
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Enter email'),
                            validator: (val) =>
                                val!.isEmpty ? "Enter a valid email" : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          // Password input field
                          TextFormField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.black),
                            decoration: textInputDecoration.copyWith(
                                hintText: "Password"),
                            validator: (val) => val!.length < 6
                                ? "Password must be at least 6 characters"
                                : null,
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            },
                          ),
                          const SizedBox(height: 20),

                          // Login button
                          GestureDetector(
                            onTap: () async {
                              dynamic result = await _auth
                                  .signInUsingEmailAndPassword(email, password);
                              if (result != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Home()), // Redirect to Home
                                );
                              } else {
                                setState(() {
                                  error =
                                      "Could not sign in with those credentials";
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: bgBlack,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(width: 2, color: mainYellow),
                              ),
                              child: const Center(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Error message
                          const SizedBox(height: 20),
                          Text(
                            error,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 20),

                          // Register prompt
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Do not have an account?",
                                style: descriptionStyle,
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  widget.toggle();
                                },
                                child: const Text(
                                  "REGISTER",
                                  style: TextStyle(
                                    color: mainBlue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
