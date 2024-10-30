import 'package:flutter/material.dart';

class NotifyMaintenancePage extends StatelessWidget {
  const NotifyMaintenancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController notificationController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notify Maintenance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: notificationController,
              decoration: const InputDecoration(
                labelText: 'Enter Maintenance Notification',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Firebase logic to notify customers
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification Sent')),
                );
              },
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
