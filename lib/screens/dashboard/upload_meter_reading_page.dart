import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

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

  // Sample customer list (replace with actual data)
  final List<String> customers = ['Customer A', 'Customer B', 'Customer C'];
  String? selectedCustomer;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _performOCR(_image!);
    }
  }

  Future<void> _performOCR(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    try {
      final recognizedText = await textRecognizer.processImage(inputImage);
      final meterReading = _extractMeterReading(recognizedText.text);
      if (meterReading != null) {
        readingController.text = meterReading.toString();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Meter reading not detected. Try again.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to recognize text: $e')),
      );
    } finally {
      textRecognizer.close();
    }
  }

  int? _extractMeterReading(String text) {
    final meterReadingPattern = RegExp(r'\b\d{3,}\b');
    final match = meterReadingPattern.firstMatch(text);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    return null;
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

    if (selectedCustomer == null ||
        accountNumber.isEmpty ||
        currentReading == null ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload a photo.')),
      );
      return;
    }
    print(readingController.text);
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
              'Reading Submitted for $selectedCustomer. Bill: \$${billAmount.toStringAsFixed(2)}')),
    );

    // TODO: Upload data to Firebase
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Upload Meter Reading',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedCustomer,
              hint: const Text('Select Customer'),
              items: customers.map((String customer) {
                return DropdownMenuItem<String>(
                  value: customer,
                  child: Text(customer),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCustomer = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Customer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Scan Meter & Upload Photo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReading,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Submit Reading'),
            ),
          ],
        ),
      ),
    );
  }
}
