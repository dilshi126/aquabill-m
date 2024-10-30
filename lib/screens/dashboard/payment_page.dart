import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Your Bill'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Integrate with payment gateway here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment Successful')),
            );
          },
          child: const Text('Pay Now'),
        ),
      ),
    );
  }
}
