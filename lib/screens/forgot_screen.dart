import 'package:flutter/material.dart';

class ForgotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Custom behavior when the back button is pressed
        Navigator.pop(
            context); // You can navigate to a specific route here if needed
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // This will pop the current screen from the navigation stack
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Forgot Password",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top image
              Stack(
                children: [
                  Image.asset(
                    'assets/forgot_screen.png', // Replace with your image asset
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
                      // Forgot Password Text
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Email Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email id",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 250),

                      // Submit Button
                      ElevatedButton(
                        onPressed: () {
                          // Handle form submission logic here
                        },
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
