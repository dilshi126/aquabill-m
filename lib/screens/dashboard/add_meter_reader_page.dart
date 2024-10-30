import 'package:flutter/material.dart';

class AddMeterReaderPage extends StatelessWidget {
  const AddMeterReaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Meter Reader'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Meter Reader Email',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Firebase logic to add a meter reader
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Meter Reader Added')),
                );
              },
              child: const Text('Add Reader'),
            ),
          ],
        ),
      ),
    );
  }
}
