import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadMeterReadingPage extends StatefulWidget {
  const UploadMeterReadingPage({Key? key}) : super(key: key);

  @override
  _UploadMeterReadingPageState createState() => _UploadMeterReadingPageState();
}

class _UploadMeterReadingPageState extends State<UploadMeterReadingPage> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController readingController = TextEditingController();
  File? _image;

  // Dummy last month reading (Replace with data from Firebase or API in real use)
  final int lastMonthReading = 120;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  int calculateUsage(int lastMonthReading, int currentReading) {
    return currentReading - lastMonthReading;
  }

  double generateBill(int usage) {
    // Example pricing: $1 per unit up to 50 units, $1.5 per unit after that
    if (usage <= 50) {
      return usage * 1.0;
    } else {
      return (50 * 1.0) + ((usage - 50) * 1.5);
    }
  }

  void _submitReading() {
    final accountNumber = accountNumberController.text;
    final currentReading = int.tryParse(readingController.text);

    if (accountNumber.isEmpty || currentReading == null || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload a photo.')),
      );
      return;
    }

    if (currentReading < lastMonthReading) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Current reading cannot be less than the previous reading.')),
      );
      return;
    }

    final usage = calculateUsage(lastMonthReading, currentReading);
    final billAmount = generateBill(usage);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              'Reading Submitted. Bill: \$${billAmount.toStringAsFixed(2)}')),
    );

    // TODO: Upload data to Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Meter Reading'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: accountNumberController,
              decoration: const InputDecoration(
                labelText: 'Customer Account Number',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: readingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Meter Reading',
              ),
            ),
            const SizedBox(height: 10),
            _image == null
                ? const Text('No Image Selected')
                : Image.file(_image!, height: 200),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Scan Meter & Upload Photo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReading,
              child: const Text('Submit Reading'),
            ),
          ],
        ),
      ),
    );
  }
}
