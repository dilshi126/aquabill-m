import 'package:flutter/material.dart';
import 'package:flutter_auth/services/auth.dart';
import 'bills_page.dart';
import 'maintenance_info.dart';
import 'complaints_page.dart';
import 'payment_page.dart';

class CustomerDashboard extends StatelessWidget {
  const CustomerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _dashboardTile(context, 'Scheduled Maintenance', Icons.build,
                MaintenanceInfo()),
            _dashboardTile(
                context, 'View Monthly Bill', Icons.receipt, BillsPage()),
            _dashboardTile(context, 'Pay Bill', Icons.payment, PaymentPage()),
            _dashboardTile(context, 'Submit Complaint', Icons.report_problem,
                ComplaintsPage()),
            TextButton(
                onPressed: () async {
                  await _auth.signOut();
                },
                child: Text("LogOUT"))
          ],
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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
