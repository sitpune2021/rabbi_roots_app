import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top image
              Stack(
                children: [
                  Image.asset(
                    'assets/reset_password.png', // Replace with your image asset
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),

              // Form Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0), // Upper left corner radius
                    topRight:
                        Radius.circular(20.0), // Upper right corner radius
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sign Up Text
                      Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      TextField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 235),

                      // Sign-Up Button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE4572E), // Orange color
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
