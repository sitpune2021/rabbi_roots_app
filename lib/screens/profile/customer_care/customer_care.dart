import 'package:flutter/material.dart';

class CustomerCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customer Care',
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
            const Text(
              'We’re here to help!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'If you have any questions or need assistance, feel free to reach out to us using one of the options below.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildOption(
              context,
              icon: Icons.call,
              title: 'Call Us',
              description: '+1-800-123-4567',
              onTap: () {
                // Implement call functionality here
              },
            ),
            const SizedBox(height: 16),
            _buildOption(
              context,
              icon: Icons.email,
              title: 'Email Us',
              description: 'support@rabbiroots.com',
              onTap: () {
                // Implement email functionality here
              },
            ),
            const SizedBox(height: 16),
            const Spacer(),
            Center(
              child: Text(
                'Available 24/7 for your convenience',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.orange.shade100,
              child: Icon(icon, size: 28, color: Colors.orange),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: CustomerCareScreen(),
    ));
