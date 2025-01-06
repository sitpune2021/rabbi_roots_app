import 'package:flutter/material.dart';

class ManageAddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Addresses',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return _buildAddressCard(context, address);
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Handle adding a new address
              },
              icon: const Icon(Icons.add),
              label: const Text('Add New Address'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size.fromHeight(50), // Full-width button
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, Map<String, String> address) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address['name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address['details'] ?? '',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Handle editing the address
              },
              icon: const Icon(Icons.edit, color: Colors.orange),
            ),
            IconButton(
              onPressed: () {
                // Handle deleting the address
                _showDeleteConfirmationDialog(context, address);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, Map<String, String> address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text(
            'Are you sure you want to delete the address for ${address['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Perform delete operation
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Sample address data
final List<Map<String, String>> addresses = [
  {
    'name': 'Home',
    'details': 'Block No. 10, Kothrud, Pune, Maharashtra 411038',
  },
  {
    'name': 'Office',
    'details': '3rd Floor, ABC Towers, MG Road, Bangalore, Karnataka 560001',
  },
];

void main() => runApp(MaterialApp(
      home: ManageAddressesScreen(),
    ));
