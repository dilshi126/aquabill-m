import 'package:flutter/material.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController complaintController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Submit Complaint',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Set AppBar color to blue
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: complaintController,
              decoration: InputDecoration(
                labelText: 'Enter your complaint',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors
                    .grey[200], // Light grey background for the text field
              ),
              maxLines: 5, // Allow multiple lines for complaints
              minLines: 3, // Minimum height for the text field
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Submit complaint logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Complaint Submitted')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding:
                    const EdgeInsets.symmetric(vertical: 15), // Button padding
                textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              child: const Text(
                'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
