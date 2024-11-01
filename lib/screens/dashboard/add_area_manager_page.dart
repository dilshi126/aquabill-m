import 'package:flutter/material.dart';

class AddAreaManagerPage extends StatefulWidget {
  const AddAreaManagerPage({Key? key}) : super(key: key);

  @override
  _AddAreaManagerPageState createState() => _AddAreaManagerPageState();
}

class _AddAreaManagerPageState extends State<AddAreaManagerPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? selectedProvince;

  final List<String> provinces = [
    'Western Province',
    'Central Province',
    'Southern Province',
    // Add other provinces as needed
  ];

  void _addAreaManager() {
    if (selectedProvince != null &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text) {
      // Logic to save area manager data (e.g., to a database or state management)
      print("Area Manager Added: ${emailController.text}");

      // Clear input fields
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      setState(() {
        selectedProvince = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Area Manager added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Area Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: const Text('Select Province'),
              value: selectedProvince,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  selectedProvince = newValue;
                });
              },
              items: provinces.map<DropdownMenuItem<String>>((String province) {
                return DropdownMenuItem<String>(
                  value: province,
                  child: Text(province),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: 'Area Manager Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addAreaManager,
              child: const Text('Add Area Manager'),
            ),
          ],
        ),
      ),
    );
  }
}
