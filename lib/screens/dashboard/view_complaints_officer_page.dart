import 'package:flutter/material.dart';

class ViewComplaintsOfficerPage extends StatelessWidget {
  const ViewComplaintsOfficerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Complaints'),
      ),
      body: ListView.builder(
        itemCount: 10, // Replace with actual data from Firebase
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Complaint #${index + 1}'),
            subtitle: const Text('Complaint details go here.'),
            trailing: IconButton(
              icon: const Icon(Icons.reply),
              onPressed: () {
                // Logic to reply or change complaint status
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Complaint Status Updated')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
