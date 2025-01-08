import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatelessWidget {
  final String name;
  final String email;
  final String profileImageUrl;
  final String mobile; // Add mobile parameter

  AccountDetailsScreen({
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.mobile, // Add mobile parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Account Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

            // Details Section
            Divider(color: Colors.grey.shade300),
            _buildDetailItem(
              icon: Icons.email,
              text: email,
            ),
            Divider(color: Colors.grey.shade300),
            _buildDetailItem(
              icon: Icons.phone,
              text:
                  '+91 $mobile', // Replace this with actual phone number if available
            ),
            Divider(color: Colors.grey.shade300),
            _buildDetailItem(
              icon: Icons.location_on,
              text:
                  'Block No. 10 Kothrud Pune,\nMaharashtra 411038', // Replace this with actual address if available
            ),
            Divider(color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
