import 'package:flutter/material.dart';

class MaintenanceInfo extends StatelessWidget {
  const MaintenanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scheduled Maintenance'),
      ),
      body: Center(
        child: Text('View all scheduled maintenance here.'),
      ),
    );
  }
}
