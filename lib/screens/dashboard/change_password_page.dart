import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  Future<void> _changePassword() async {
    setState(() {
      isLoading = true;
    });

    bool isOldPasswordValid =
        await validateOldPassword(oldPasswordController.text);

    if (!isOldPasswordValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Old password is incorrect')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    bool passwordChanged = await changePassword(newPasswordController.text);

    if (passwordChanged) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password successfully changed')),
      );
      // Redirect to MeterReaderDashboard page after password change
      Navigator.pushReplacementNamed(context, '/meter_reader_dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to change password')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Old Password',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _changePassword,
                    child: const Text('Change Password'),
                  ),
          ],
        ),
      ),
    );
  }
}

// Mock functions for illustration. Replace these with real functions from your authentication service
Future<bool> validateOldPassword(String oldPassword) async {
  await Future.delayed(const Duration(seconds: 1)); // Simulate network call
  return true; // Return actual validation result
}

Future<bool> changePassword(String newPassword) async {
  await Future.delayed(const Duration(seconds: 1)); // Simulate network call
  return true; // Return actual result of password change
}
