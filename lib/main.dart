import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'models/UserModel.dart';
import 'services/auth.dart';
import 'wrapper.dart';
import 'screens/dashboard/customer_dashboard.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: UserModel(uid: ""), // Initial user state
      value: AuthServices().user, // Firebase user stream
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Redirect to the dashboard based on authentication status
        home:
            Wrapper(), // Wrapper determines if the user goes to login or dashboard
        routes: {
          '/dashboard': (context) =>
              const CustomerDashboard(), // Route to Customer Dashboard
        },
      ),
    );
  }
}
