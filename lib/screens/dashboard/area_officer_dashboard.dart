import 'package:flutter/material.dart';
import 'package:flutter_auth/services/auth.dart';
import 'view_complaints_officer_page.dart';
import 'add_meter_reader_page.dart';
import 'notify_maintenance_page.dart';
import 'footer.dart'; // Import the footer

class AreaOfficerDashboard extends StatelessWidget {
  const AreaOfficerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    const String managerEmail = 'shongde94@gmail.com';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Area Officer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/logo.png',
              height: 60,
            ),
          ],
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile section with image and email
            Row(
              children: [
                Image.asset(
                  'assets/images/man.png',
                  height: 60,
                  width: 60,
                ),
                const SizedBox(width: 10),
                Text(
                  managerEmail,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dashboard functions in a grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _dashboardTile(context, 'View Complaints', Icons.report,
                    const ViewComplaintsOfficerPage()),
                _dashboardTile(context, 'Add Meter Reader', Icons.person_add,
                    const AddMeterReaderPage()),
                _dashboardTile(context, 'Notify Maintenance', Icons.build,
                    const NotifyMaintenancePage()),
              ],
            ),
            const SizedBox(height: 20),

            // Logout button
            _logoutButton(context, _auth),
            const SizedBox(height: 20),

            // Footer section
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(BuildContext context, AuthServices auth) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
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
        color: Colors.blue, // Blue box color for uniformity
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
