import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/sign_in_screen.dart';
import 'package:rabbi_roots/screens/splash_screens/splash_screen_2.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Top image with skip button
            Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/splash_screen_1.png', // Replace with your image asset
                      width: double.infinity,

                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      child: TextButton(
                        onPressed: () {
                          // Handle skip action
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Title
                          Text(
                            "All Your Favorites",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 10),

                          // Subtitle
                          Text(
                            "Your favorite items, all in one place.\nEnjoy a seamless shopping experience.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 30),

                          // Dots indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),

                          // Next button
                          ElevatedButton(
                            onPressed: () {
                              // Handle next action
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OnboardingScreen2(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color(0xFFE4572E), // Orange color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              "Next",
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
