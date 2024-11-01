import 'package:flutter/material.dart';

class ViewCustomersPage extends StatefulWidget {
  const ViewCustomersPage({Key? key}) : super(key: key);

  @override
  _ViewCustomersPageState createState() => _ViewCustomersPageState();
}

class _ViewCustomersPageState extends State<ViewCustomersPage> {
  final List<Map<String, String>> customers = [];
  String? selectedProvince;
  String? selectedDistrict;

  void _addDummyCustomer() {
    // This function is just for demonstration purposes to add dummy customers
    customers.add({
      'name': 'John Doe',
      'accountNumber': '12345',
      'province': 'Western Province',
      'district': 'Colombo',
    });
    customers.add({
      'name': 'Jane Smith',
      'accountNumber': '67890',
      'province': 'Central Province',
      'district': 'Kandy',
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _addDummyCustomer(); // Add some dummy data for demonstration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Customers'),
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
              items: [
                'Western Province',
                'Central Province',
                'Southern Province',
                // Add other provinces
              ].map<DropdownMenuItem<String>>((String province) {
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
              onChanged: (String? newValue) {
                setState(() {
                  selectedDistrict = newValue;
                });
              },
              items: selectedProvince != null
                  ? [
                      'Colombo',
                      'Gampaha',
                      'Kalutara', // Sample districts; replace with actual districts
                    ].map<DropdownMenuItem<String>>((String district) {
                      return DropdownMenuItem<String>(
                        value: district,
                        child: Text(district),
                      );
                    }).toList()
                  : [],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Customer Name')),
                    DataColumn(label: Text('Account Number')),
                    DataColumn(label: Text('Province')),
                    DataColumn(label: Text('District')),
                  ],
                  rows: customers
                      .where((customer) =>
                          (selectedProvince == null ||
                              customer['province'] == selectedProvince) &&
                          (selectedDistrict == null ||
                              customer['district'] == selectedDistrict))
                      .map<DataRow>((customer) {
                    return DataRow(cells: [
                      DataCell(Text(customer['name']!)),
                      DataCell(Text(customer['accountNumber']!)),
                      DataCell(Text(customer['province']!)),
                      DataCell(Text(customer['district']!)),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
