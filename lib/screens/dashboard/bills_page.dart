import 'package:flutter/material.dart';
import 'payment_page.dart';

class BillsPage extends StatelessWidget {
  const BillsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Monthly Bills'),
      ),
      body: ListView.builder(
        itemCount: 12, // Example: 12 months
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Bill for Month ${index + 1}'),
            subtitle: Text('Amount: \$100'),
            trailing: IconButton(
              icon: const Icon(Icons.payment),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
