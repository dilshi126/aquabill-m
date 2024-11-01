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
final TextEditingController confirmPasswordController = TextEditingController();
final AuthServices _auth = AuthServices();

String email = "";
String password = "";
String confirmPassword = "";
String? selectedArea; // To hold the selected area

class _AddMeterReaderPageState extends State<AddMeterReaderPage> {
  final List<String> areas = [
    'Area 1',
    'Area 2',
    'Area 3',
    'Area 4',
    // Add more areas as needed
  ];

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
          'area': selectedArea, // Save the selected area
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
        title: const Text(
          'Add Meter Reader',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text('Select Area'),
              value: selectedArea,
              onChanged: (String? newValue) {
                setState(() {
                  selectedArea = newValue;
                });
              },
              items: areas.map<DropdownMenuItem<String>>((String area) {
                return DropdownMenuItem<String>(
                  value: area,
                  child: Text(area),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                email = emailController.text.trim();
                password = passwordController.text.trim();
                confirmPassword = confirmPasswordController.text.trim();
                if (email.isNotEmpty &&
                    password.isNotEmpty &&
                    selectedArea != null) {
                  if (password == confirmPassword) {
                    await _addMeterReader(email, password);
                  } else {
                    print("Passwords do not match");
                  }
                } else {
                  print("Enter all fields");
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
