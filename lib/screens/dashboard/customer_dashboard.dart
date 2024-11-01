import 'package:flutter/material.dart';
import 'package:flutter_auth/services/auth.dart';
import 'bills_page.dart';
import 'maintenance_info.dart';
import 'complaints_page.dart';
import 'payment_page.dart';
import 'footer.dart'; // Import the footer

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    final String accountNumber =
        '123456'; // Replace with the actual account number

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/logo.png', height: 80), // Logo
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Account Information Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/man.png',
                    height: 40), // Account Icon
                const SizedBox(width: 8),
                Text(
                  'Account Number: $accountNumber',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Functions Section
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _dashboardTile(context, 'View Monthly Bill',
                            Icons.receipt, BillsPage()),
                        _dashboardTile(context, 'Scheduled Maintenance',
                            Icons.build, MaintenanceInfo()),
                        _dashboardTile(
                            context, 'Pay Bill', Icons.payment, PaymentPage()),
                        _dashboardTile(context, 'Submit Complaint',
                            Icons.report_problem, ComplaintsPage()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _logoutButton(context, _auth), // Styled logout button
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Footer Section - now part of scrollable content
            Footer(),
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
        color: Colors.blueAccent, // Blue box color
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
