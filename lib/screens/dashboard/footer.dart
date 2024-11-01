import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                '1939 Hotline',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 16),
              Icon(Icons.email, color: Colors.white),
              const SizedBox(width: 8),
              const Text(
                'Email aquabill@gmail.com',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'National Water Supply and Drainage Board, Galle Road, Ratmalana, Sri Lanka',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Copyright 2024 AquaBill. All rights reserved. Designed and developed by Group 22.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
