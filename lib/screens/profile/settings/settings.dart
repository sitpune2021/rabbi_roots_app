import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'General',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          _buildSwitchTile(
            title: 'Notifications',
            subtitle: 'Enable or disable notifications',
            value: true,
            onChanged: (bool value) {
              // Handle notification toggle
            },
          ),
          _buildTile(
            context,
            icon: Icons.language,
            title: 'Language',
            subtitle: 'Change app language',
            onTap: () {
              // Navigate to language settings
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          _buildTile(
            context,
            icon: Icons.lock,
            title: 'Privacy',
            subtitle: 'Manage privacy settings',
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          _buildTile(
            context,
            icon: Icons.security,
            title: 'Security',
            subtitle: 'Update password or security settings',
            onTap: () {
              // Navigate to security settings
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Other',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          _buildTile(
            context,
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get support or FAQs',
            onTap: () {
              // Navigate to help and support
            },
          ),
          _buildTile(
            context,
            icon: Icons.info_outline,
            title: 'About Us',
            subtitle: 'Learn more about the app',
            onTap: () {
              // Navigate to about us
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, size: 24, color: Colors.black),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }
}

void main() => runApp(MaterialApp(
      home: SettingsScreen(),
    ));
