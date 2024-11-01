import 'package:flutter/material.dart';

class MaintenanceInfo extends StatelessWidget {
  const MaintenanceInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scheduled Maintenance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue, // Set AppBar color to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // Space between title and boxes
            Expanded(
              child: ListView(
                children: [
                  MaintenanceBox(
                    title: 'Area A',
                    date: 'November 3, 2024',
                    time: '10:00 AM - 2:00 PM',
                    details: 'Scheduled maintenance for water supply.',
                  ),
                  MaintenanceBox(
                    title: 'Area B',
                    date: 'November 4, 2024',
                    time: '1:00 PM - 5:00 PM',
                    details: 'Pipe replacement work will be conducted.',
                  ),
                  // Add more MaintenanceBox widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaintenanceBox extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String details;

  const MaintenanceBox({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Date: $date'),
            Text('Time: $time'),
            const SizedBox(height: 8),
            Text(details),
          ],
        ),
      ),
    );
  }
}
