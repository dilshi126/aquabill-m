import 'package:flutter/material.dart';
import 'package:flutter_auth/screens/dashboard/change_password_page.dart';
import 'package:flutter_auth/screens/dashboard/upload_meter_reading_page.dart';
import 'package:flutter_auth/screens/dashboard/view_registered_customers_page.dart';
import 'package:flutter_auth/services/auth.dart';
import 'footer.dart'; // Import the footer

class MeterReaderDashboard extends StatelessWidget {
  const MeterReaderDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    final String userEmail = 'shandilshanx@gmail.com';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: const Text(
                'Meter Reader ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Image.asset(
                'assets/images/logo.png',
                height: 40, // Adjust the size as needed
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Information Section
            Row(
              children: [
                Image.asset(
                  'assets/images/man.png',
                  height: 50,
                  width: 50,
                ),
                const SizedBox(width: 10),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Dashboard Tiles
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _dashboardTile(context, 'Upload Meter Reading', Icons.camera,
                    const UploadMeterReadingPage()),
                _dashboardTile(context, 'View Registered Customers',
                    Icons.visibility, const ViewRegisteredCustomersPage()),
                _dashboardTile(context, 'Change Password', Icons.password,
                    const ChangePasswordPage()),
              ],
            ),
            const SizedBox(height: 20),
            _logoutButton(context, _auth), // Styled logout button
            const SizedBox(height: 20),

            // Footer Section wrapped in Padding and Container to prevent overflow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity, // Ensure the footer takes full width
                child: Footer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context, AuthServices auth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue, // Box color for the logout button
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton(
        onPressed: () async {
          await auth.signOut();
        },
        child: const Text(
          "LOGOUT",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  GestureDetector _dashboardTile(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      ),
      child: Card(
        color: Colors.blue, // Set tile color to blue
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: 50,
                  color: Colors.white), // White icon color for contrast
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white), // White text color for contrast
              ),
            ],
          ),
        ),
      ),
    );
  }
}
