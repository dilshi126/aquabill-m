import 'package:flutter/material.dart';

class ViewNonRegisteredCustomersPage extends StatelessWidget {
  const ViewNonRegisteredCustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Non-Registered Customers'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual data from Firebase
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Customer #${index + 1}'),
            subtitle: const Text('Details about this customer...'),
          );
        },
      ),
    );
  }
}
