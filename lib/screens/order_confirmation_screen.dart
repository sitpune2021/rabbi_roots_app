import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/order_tracking_screen.dart';

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Green checkmark icon
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              SizedBox(height: 20),
              // Thank you message
              Text(
                'Thank you for choosing us!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 10),
              // Order success message
              Text(
                'Your order #1234 has been successfully\nplaced. Track your order now.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              // Track order button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  // Add button functionality here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderTrackingScreen()),
                  );
                },
                child: Text(
                  'Track Your Order',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
