import 'package:flutter/material.dart';

class NotifyMaintenancePage extends StatefulWidget {
  const NotifyMaintenancePage({Key? key}) : super(key: key);

  @override
  _NotifyMaintenancePageState createState() => _NotifyMaintenancePageState();
}

class _NotifyMaintenancePageState extends State<NotifyMaintenancePage> {
  final TextEditingController notificationController = TextEditingController();
  String? selectedArea;

  // Sample areas for demonstration; replace with actual areas as needed
  final List<String> areas = [
    'Area 1',
    'Area 2',
    'Area 3',
    'Area 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notify Maintenance',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        // Enable scrolling if content overflows
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Stretch children to fill width
          children: [
            DropdownButton<String>(
              hint: const Text('Select Area'),
              value: selectedArea,
              isExpanded: true, // Makes the dropdown take the full width
              onChanged: (String? newValue) {
                setState(() {
                  selectedArea = newValue; // Update the selected area
                });
              },
              items: areas.map<DropdownMenuItem<String>>((String area) {
                return DropdownMenuItem<String>(
                  value: area,
                  child: Text(area),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: notificationController,
              decoration: const InputDecoration(
                labelText: 'Enter Maintenance Notification',
              ),
              maxLines: 3, // Allows multiple lines of input
              // Set text field to expand and avoid overflow
              textAlignVertical: TextAlignVertical.top,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedArea != null &&
                    notificationController.text.isNotEmpty) {
                  // Firebase logic to notify customers in the selected area
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notification Sent')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please select an area and enter a notification'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
