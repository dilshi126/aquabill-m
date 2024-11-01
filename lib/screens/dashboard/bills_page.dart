import 'package:flutter/material.dart';
import 'payment_page.dart';

class BillsPage extends StatelessWidget {
  const BillsPage({Key? key}) : super(key: key);

  // Sample data for monthly bills (replace with real data)
  final List<Map<String, dynamic>> bills = const [
    {
      'month': 'January',
      'unitsUsed': 50,
      'usageCharges': 50.0,
      'serviceCharges': 5.0,
      'dueAmount': 10.0,
    },
    {
      'month': 'February',
      'unitsUsed': 60,
      'usageCharges': 60.0,
      'serviceCharges': 5.0,
      'dueAmount': 0.0,
    },
    // Add more monthly data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Your Monthly Bills',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: bills.length,
        itemBuilder: (context, index) {
          final bill = bills[index];
          final totalBill =
              bill['usageCharges'] + bill['serviceCharges'] + bill['dueAmount'];
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bill for ${bill['month']}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Units Used: ${bill['unitsUsed']} units'),
                    Text(
                        'Usage Charges: \$${bill['usageCharges'].toStringAsFixed(2)}'),
                    Text(
                        'Service Charges: \$${bill['serviceCharges'].toStringAsFixed(2)}'),
                    if (bill['dueAmount'] > 0)
                      Text(
                          'Due Amount: \$${bill['dueAmount'].toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),
                    Text(
                      'Total Bill: \$${totalBill.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentPage()),
                          );
                        },
                        child: const Text('Pay Now'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
