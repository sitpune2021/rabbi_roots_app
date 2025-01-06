import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rabbi_roots/screens/home_screen.dart'; // Assuming HomeScreen is imported

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                "assets/no_internet.png",
                height: 200,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Please check your Internet Connection",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to HomeScreen using GetX navigation
                Get.to(() => HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Try again',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
