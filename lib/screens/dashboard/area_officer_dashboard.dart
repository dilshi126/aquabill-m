import 'package:flutter/material.dart';
import 'package:flutter_auth/services/auth.dart';
import 'view_complaints_officer_page.dart';
import 'add_meter_reader_page.dart';
import 'notify_maintenance_page.dart';

class AreaOfficerDashboard extends StatelessWidget {
  const AreaOfficerDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthServices _auth = AuthServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Area Officer Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
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
