import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding for better UI
        child: Column(
          children: [
            _buildProfileOption("Privacy Policy", context),
            Divider(), // Added divider for separation
            _buildProfileOption("Terms of Service", context),
            Divider(),
            _buildProfileOption("Contact Us", context),
          ],
        ),
      ),
    );
  }

  /// Builds a profile option tile with a title and navigation action.
  Widget _buildProfileOption(String title, BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        String url;

        // Determine the URL based on the title
        switch (title) {
          case "Privacy Policy":
            url = 'https://rabbiroots.com/';
            break;
          case "Terms of Service":
            url = 'https://rabbiroots.com/';
            break;
          case "Contact Us":
            url = 'https://rabbiroots.com'; // Updated Contact URL
            break;
          default:
            url = 'https://rabbiroots.com/';
        }

        _launchURL(url, context);
      },
    );
  }

  /// Launches the given URL in the device's default browser.
  ///
  /// [url] is the URL string to be launched.
  /// [context] is used to display a SnackBar in case of an error.
  Future<void> _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);

    // Check if the device can launch the URL
    if (await canLaunchUrl(uri)) {
      // Attempt to launch the URL
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Opens in external browser
      );

      if (!launched) {
        // If launchUrl returns false, show an error message
        _showErrorSnackBar(context, 'Could not launch the URL.');
      }
    } else {
      // If the URL cannot be launched, show an error message
      _showErrorSnackBar(context, 'Could not launch the URL.');
    }
  }

  /// Displays a SnackBar with the given error message.
  ///
  /// [context] is used to show the SnackBar.
  /// [message] is the error message to display.
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
