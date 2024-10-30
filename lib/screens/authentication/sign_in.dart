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
      backgroundColor: bgBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgBlack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 10),
          child: Column(
            children: [
              // App Name "AquaBill"
              const Center(
                child: Text(
                  "AquaBill",
                  style: TextStyle(
                    color: Colors.blue, // Blue color for the text
                    fontWeight: FontWeight.bold, // Bold
                    fontSize: 36, // Large font size
                  ),
                ),
              ),
              const SizedBox(height: 20), // Spacing after the app name

              // Description
              const Text(
                description,
                style: descriptionStyle,
              ),

              // Spacing
              const SizedBox(height: 30),

              // Screen Name "Sign In"
              const Text(
                "SIGN IN",
                style: TextStyle(
                  color: Colors.black87, // Black color for the text
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Slightly smaller than the app name
                ),
              ),
              const SizedBox(height: 20),

              // Center image
              Center(
                child: Image.asset(
                  'assets/images/man.png',
                  height: 150,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email input field
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
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
                        style: const TextStyle(color: Colors.white),
                        decoration:
                            textInputDecoration.copyWith(hintText: "password"),
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

                      // Login button (moved here)
                      GestureDetector(
                        // Login button onTap function
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

                        //new login button ontap function

                        // Login button onTap function
                        // onTap: () async {
                        //   try {
                        //     // Sign in the user using Firebase Authentication
                        //     dynamic result = await _auth
                        //         .signInUsingEmailAndPassword(email, password);
                        //     if (result != null) {
                        //       // Get the user UID from the Authentication
                        //       String uid = result.user.uid;

                        //       // Reference the Firestore collection 'user' and get the document with the matching UID
                        //       DocumentSnapshot userDoc = await FirebaseFirestore
                        //           .instance
                        //           .collection('user')
                        //           .doc(uid)
                        //           .get();

                        //       // Check if the document exists and retrieve the role
                        //       if (userDoc.exists) {
                        //         String role = userDoc['role'] ??
                        //             ""; // Use ?? to provide a default value

                        //         print(
                        //             "User document exists. Role is: $role"); // Log the role

                        //         // Check the role and navigate accordingly
                        //         if (role.toLowerCase().trim() == "customer") {
                        //           Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => TestScreen()),
                        //           );
                        //         } else if (role.toLowerCase().trim() == "" ||
                        //             role.toLowerCase().trim() == null) {
                        //           Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => TestScreen()),
                        //           );
                        //         } else {
                        //           Navigator.pushReplacement(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => TestScreen()),
                        //           );
                        //         }
                        //       } else {
                        //         setState(() {
                        //           error = "User data not found in the database";
                        //         });
                        //       }
                        //     } else {
                        //       setState(() {
                        //         error =
                        //             "Could not sign in with those credentials";
                        //       });
                        //     }
                        //   } catch (e) {
                        //     setState(() {
                        //       error = "An error occurred: $e";
                        //     });
                        //   }
                        // },

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
      ),
    );
  }
}
