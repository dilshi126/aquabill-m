import 'package:flutter/material.dart';

class ChangePricingPage extends StatefulWidget {
  const ChangePricingPage({Key? key}) : super(key: key);

  @override
  _ChangePricingPageState createState() => _ChangePricingPageState();
}

class _ChangePricingPageState extends State<ChangePricingPage> {
  final List<int> unitRanges = [
    25,
    50,
    75,
    100,
    200,
    500,
    1000,
    2000,
    10000,
    20000,
    999999
  ]; // Represents the upper limits for units
  final List<double> usageCharges =
      List.filled(11, 60.0); // Default usage charge
  final List<double> serviceCharges = [
    500.00,
    750.00,
    1500.00,
    1750.00,
    2000.00,
    3000.00,
    5000.00,
    10000.00,
    30000.00,
    60000.00,
    130000.00
  ]; // Default monthly service charge

  void _saveChanges() {
    // Logic to save the changes (e.g., to a database or state management)
    // You can implement your saving mechanism here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pricing changes saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Pricing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Adjust Usage Charges and Monthly Service Charges',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: unitRanges.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('00-${unitRanges[index]} units'),
                          Column(
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                    labelText: 'Usage Charge Rs.'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  usageCharges[index] =
                                      double.tryParse(value) ??
                                          usageCharges[index];
                                },
                              ),
                              TextField(
                                decoration: const InputDecoration(
                                    labelText: 'Monthly Service Charge Rs.'),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  serviceCharges[index] =
                                      double.tryParse(value) ??
                                          serviceCharges[index];
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
