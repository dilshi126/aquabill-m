import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/dashboard/area_officer_dashboard.dart';
import 'package:flutter_auth/screens/dashboard/customer_dashboard.dart';
import 'package:flutter_auth/screens/dashboard/meter_reader_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_auth/models/UserModel.dart';
import 'package:flutter_auth/screens/home/home.dart';
import 'package:flutter_auth/screens/authentication/authenticate.dart';

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel?>(context);

//     // Redirect based on the authentication state
//     if (user == null) {
//       return const Authenticate();
//     } else {
//       return const Home();
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/screens/test_screen.dart';

class Wrapper extends StatelessWidget {
  // Function to get user role from Firestore
  Future<String?> _getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('user').doc(uid).get();
      return userDoc.exists ? userDoc['role'] as String? : null;
    } catch (e) {
      print("Error fetching user role: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    print("user id is: ");
    print(user?.uid);

    if (user == null) {
      // If the user is not authenticated, go to the authentication screen
      return const Authenticate();
    } else {
      // Use FutureBuilder to fetch and handle the user role
      return FutureBuilder<String?>(
        future: _getUserRole(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasData) {
            //Test Print
            print("Hola! Snapshot has data");
            String role = snapshot.data!.toLowerCase().trim();
            print("Role is : ");
            print(role);
            if (role == 'customer') {
              return CustomerDashboard();
              //TestScreen(); // Redirect to TestScreen if the role is 'customer'
            } else if (role == 'meeterreader') {
              return MeterReaderDashboard();
            } else if (role == 'areamanager') {
              return AreaOfficerDashboard();
            } else {
              return const Home(); // Redirect to Home for other roles
            }
          } else {
            //Test Print
            print("Hola! Snapshot has No data");
            if (user == null) {
              return const Authenticate();
            } else {
              return const Home();
            }
          }
        },
      );
    }
  }
}
