// import 'package:flutter/material.dart';
// import 'package:flutter_auth/models/UserModel.dart';
// import 'package:flutter_auth/screens/home/home.dart';
// import 'package:flutter_auth/services/auth.dart';
// import 'package:provider/provider.dart';

// class AddMeterReaderPage extends StatefulWidget {
//   const AddMeterReaderPage({Key? key}) : super(key: key);

//   @override
//   State<AddMeterReaderPage> createState() => _AddMeterReaderPageState();
// }

// final TextEditingController emailController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();
// final AuthServices _auth = AuthServices();

// String email = "";
// String password = "";

// class _AddMeterReaderPageState extends State<AddMeterReaderPage> {
//   Future<void> _addMeterReader(String email, String password) async {
//     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
//     if (result != null) {

//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(
//       //       builder: (context) => const Home()), // Redirect to Home
//       // );
//     } else {
//       setState(() {
//         // error = "Please enter a valid email!";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//       email = emailController.text.trim();
//       password = passwordController.text.trim();
//     });

//     final user = Provider.of<UserModel?>(context);
//     String? uid = user?.uid;
//     const role = "meeterreader";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Meter Reader'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Meter Reader Email',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (email != null && password != null) {
//                   _addMeterReader(email, password);
//                 } else {
//                   print("Enter Email and Password");
//                 }

//                 //ToDo add method
//               },
//               // Firebase logic to add a meter reader

//               child: const Text('Add Reader'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_auth/models/UserModel.dart';
// import 'package:flutter_auth/screens/dashboard/area_officer_dashboard.dart';
// import 'package:flutter_auth/screens/home/home.dart';
// import 'package:flutter_auth/services/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';

// class AddMeterReaderPage extends StatefulWidget {
//   const AddMeterReaderPage({Key? key}) : super(key: key);

//   @override
//   State<AddMeterReaderPage> createState() => _AddMeterReaderPageState();
// }

// final TextEditingController emailController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();
// final AuthServices _auth = AuthServices();

// String email = "";
// String password = "";

// class _AddMeterReaderPageState extends State<AddMeterReaderPage> {
//   Future<void> _addMeterReader(String email, String password) async {
//     // Register user with email and password
//     dynamic results =
//         await _auth.registerWithEmailAndPasswordAsAreaM(email, password);

//     if (results != null) {
//       print("Result is not null!");

//       // Get the newly created user's UID
//       String uid = results.uid;
//       const role = "meterreader";

//       // Save user details in Firestore and check if operation was successful
//       try {
//         await FirebaseFirestore.instance.collection('user').doc(uid).set({
//           'email': email,
//           'role': role,
//           'uid': uid,
//         });

//         // Only navigate if data was successfully saved in Firestore
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   const AreaOfficerDashboard()), // Redirect to Dashboard
//         );
//       } catch (e) {
//         print("Error saving user data to Firestore: $e");
//       }
//     } else {
//       setState(() {
//         // Show an error if registration fails
//         print("Registration failed. Please check the email and password.");
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Meter Reader'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Meter Reader Email',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 email = emailController.text.trim();
//                 password = passwordController.text.trim();
//                 if (email.isNotEmpty && password.isNotEmpty) {
//                   await _addMeterReader(email, password);
//                 } else {
//                   print("Enter Email and Password");
//                 }
//               },
//               child: const Text('Add Reader'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_auth/models/UserModel.dart';
import 'package:flutter_auth/screens/dashboard/area_officer_dashboard.dart';
import 'package:flutter_auth/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddMeterReaderPage extends StatefulWidget {
  const AddMeterReaderPage({Key? key}) : super(key: key);

  @override
  State<AddMeterReaderPage> createState() => _AddMeterReaderPageState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final AuthServices _auth = AuthServices();

String email = "";
String password = "";

class _AddMeterReaderPageState extends State<AddMeterReaderPage> {
  Future<void> _addMeterReader(String email, String password) async {
    try {
      // Firebase REST API endpoint for user registration
      final url =
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDk67wyJ8Fgy-0t4lQ__EYTs4Rl-jyv2U4';

      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['localId'] != null) {
        // Registration successful; save user data to Firestore
        String uid = responseData['localId'];
        const role = "meterreader";

        await FirebaseFirestore.instance.collection('user').doc(uid).set({
          'email': email,
          'role': role,
          'uid': uid,
        });

        // Navigate to Area Officer Dashboard upon successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AreaOfficerDashboard()),
        );
      } else {
        print("Error: ${responseData['error']['message']}");
      }
    } catch (e) {
      print("Error registering meter reader: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meter Reader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Meter Reader Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                email = emailController.text.trim();
                password = passwordController.text.trim();
                if (email.isNotEmpty && password.isNotEmpty) {
                  await _addMeterReader(email, password);
                } else {
                  print("Enter Email and Password");
                }
              },
              child: const Text('Add Reader'),
            ),
          ],
        ),
      ),
    );
  }
}
