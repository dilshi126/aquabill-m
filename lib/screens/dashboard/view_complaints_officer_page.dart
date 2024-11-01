import 'package:flutter/material.dart';

class ViewComplaintsOfficerPage extends StatefulWidget {
  const ViewComplaintsOfficerPage({Key? key}) : super(key: key);

  @override
  _ViewComplaintsOfficerPageState createState() =>
      _ViewComplaintsOfficerPageState();
}

class _ViewComplaintsOfficerPageState extends State<ViewComplaintsOfficerPage> {
  // Example complaints data, should be replaced with actual data from Firebase
  final List<Map<String, dynamic>> complaints = [
    {'id': 1, 'details': 'Complaint about product quality', 'status': 'New'},
    {'id': 2, 'details': 'Issue with delivery time', 'status': 'New'},
    {
      'id': 3,
      'details': 'Product not working as expected',
      'status': 'Resolved'
    },
    // Add more complaints as needed
  ];

  @override
  void initState() {
    super.initState();
    // Sorting complaints so that new ones come first
    complaints.sort((a, b) => b['status'].compareTo(a['status']));
  }

  void _updateStatus(int index, String newStatus) {
    setState(() {
      complaints[index]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Complaint Status Updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Complaints',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          final complaint = complaints[index];
          return ListTile(
            title: Text('Complaint #${complaint['id']}'),
            subtitle: Text(complaint['details']),
            trailing: DropdownButton<String>(
              value: complaint['status'],
              items: <String>['New', 'In Progress', 'Resolved']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _updateStatus(index, newValue);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
