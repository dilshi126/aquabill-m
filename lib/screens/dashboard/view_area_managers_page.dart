import 'package:flutter/material.dart';

class ViewAreaManagersPage extends StatefulWidget {
  const ViewAreaManagersPage({Key? key}) : super(key: key);

  @override
  _ViewAreaManagersPageState createState() => _ViewAreaManagersPageState();
}

class _ViewAreaManagersPageState extends State<ViewAreaManagersPage> {
  final List<Map<String, String>> areaManagers = [];
  String? selectedProvince;

  void _addDummyAreaManager() {
    // This function is just for demonstration purposes to add dummy area managers
    areaManagers.add({
      'email': 'manager1@example.com',
      'province': 'Western Province',
    });
    areaManagers.add({
      'email': 'manager2@example.com',
      'province': 'Central Province',
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _addDummyAreaManager(); // Add some dummy data for demonstration
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Area Managers'),
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
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Province')),
                  ],
                  rows: areaManagers
                      .where((manager) =>
                          selectedProvince == null ||
                          manager['province'] == selectedProvince)
                      .map<DataRow>((manager) {
                    return DataRow(cells: [
                      DataCell(Text(manager['email']!)),
                      DataCell(Text(manager['province']!)),
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
