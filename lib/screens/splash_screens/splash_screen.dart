import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/home_screen.dart';
import 'package:rabbi_roots/screens/splash_screens/splash_screen_1.dart';

class SplashScreen extends StatefulWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key, required this.isLoggedIn});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  // Navigate based on the login status
  _navigateBasedOnLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds

    // Check if the user is logged in and navigate accordingly
    if (widget.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      ); // Navigate to OnboardingScreen
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash_screen_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child:
                Image.asset("assets/rabbi_roots_logo.png"), // Center the logo
          ),
        ),
      ),
    );
  }
}
