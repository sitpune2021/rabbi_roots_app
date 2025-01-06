import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/order_confirmation_screen.dart';

class CardPaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Make Payment"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                "assets/credit_card.png",
                width: 300,
                height: 180,
              ),
            ),
            SizedBox(height: 24),
            _buildInputField(
              label: "Card Number",
              hintText: "1234 1234 1234 1234",
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/visa.png",
                    width: 24,
                  ),
                  SizedBox(width: 8),
                  Image.asset(
                    "assets/visa.png",
                    width: 24,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: "Expiry",
                    hintText: "MM / YY",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    label: "CVC",
                    hintText: "CVC",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInputField(
              label: "Name",
              hintText: "First     Middle     Surname",
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Handle payment
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OrderConfirmationScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Make Payment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // Handle cancel
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.grey),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
