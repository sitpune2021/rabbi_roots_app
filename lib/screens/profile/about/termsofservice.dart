import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Terms of Service',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Welcome to Rabbi Roots! These terms of service outline the rules and guidelines that govern your use of our services and products. By using our services, you agree to these terms of service. If you do not agree with any part of these terms, please do not use our services.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Acceptance of Terms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'By using our services, you agree to these terms. If you do not agree with any part of these terms, please do not use our services.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              '2. Changes to Terms',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We reserve the right to update these terms at any time. If we make changes to these terms, we will notify you by posting the updated terms on our website. It is your responsibility to review these terms regularly to ensure that you are aware of any changes.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              '3. Use of Services',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'You may use our services only for lawful purposes and in accordance with these terms. We reserve the right to terminate your account at any time for any reason, including but not limited to violations of these terms.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            const Text(
              '4. Privacy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'We collect and use personal information to provide our services and to improve our services. By using our services, you agree to our privacy policy. We may also collect and use data for the following purposes: to comply with legal obligations, to protect our rights and property, for analytics and research purposes.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
