import 'package:flutter/material.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage({Key? key}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController confirmAccountNumberController =
      TextEditingController();
  String? selectedProvince;
  String? selectedDistrict;

  final List<String> provinces = [
    'Western Province',
    'Central Province',
    'Southern Province',
    // Add other provinces
  ];

  final Map<String, List<String>> districts = {
    'Western Province': ['Colombo', 'Gampaha', 'Kalutara'],
    'Central Province': ['Kandy', 'Matale', 'Nuwara Eliya'],
    'Southern Province': ['Galle', 'Matara', 'Hambantota'],
    // Add other provinces and their districts
  };

  void _addCustomer() {
    if (selectedProvince != null &&
        selectedDistrict != null &&
        nameController.text.isNotEmpty &&
        accountNumberController.text.isNotEmpty &&
        accountNumberController.text == confirmAccountNumberController.text) {
      // Logic to save customer data (e.g., to a database or state management)
      print("Customer Added: ${nameController.text}");

      // Clear input fields
      nameController.clear();
      accountNumberController.clear();
      confirmAccountNumberController.clear();
      setState(() {
        selectedProvince = null;
        selectedDistrict = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer added successfully!')),
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
        title: const Text('Add Customer'),
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
                  selectedDistrict =
                      null; // Reset district when province changes
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
            DropdownButton<String>(
              hint: const Text('Select District'),
              value: selectedDistrict,
              isExpanded: true,
              onChanged: selectedProvince == null
                  ? null
                  : (String? newValue) {
                      setState(() {
                        selectedDistrict = newValue;
                      });
                    },
              items: selectedProvince != null
                  ? districts[selectedProvince]!
                      .map<DropdownMenuItem<String>>((String district) {
                      return DropdownMenuItem<String>(
                        value: district,
                        child: Text(district),
                      );
                    }).toList()
                  : [],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Customer Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: accountNumberController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmAccountNumberController,
              decoration:
                  const InputDecoration(labelText: 'Confirm Account Number'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCustomer,
              child: const Text('Add Customer'),
            ),
          ],
        ),
      ),
    );
  }
}
