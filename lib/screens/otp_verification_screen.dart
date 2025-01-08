import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'dart:async';

import 'package:rabbi_roots/screens/sign_in_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String otp; // OTP sent to the user
  final String mobileNo; // User's mobile number
  final String reg_no; // User's registration number

  OtpVerificationScreen(
      {required this.otp, required this.mobileNo, required this.reg_no});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _timeLeft = 10;
  late Timer _timer;
  String _enteredOtp = ""; // Store the entered OTP
  bool _isLoading = false;
  String? _errorMessage;
  String? flag = "1";
  Key otpFieldKey = UniqueKey(); // Unique key for OtpTextField

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _resendOtp() {
    setState(() {
      _timeLeft = 60; // Reset timer
    });
    _startTimer();
    // You can call your resend OTP API here if needed
  }

  // Function to validate OTP
  Future<void> _validateOtp() async {
    if (_enteredOtp.isEmpty || _enteredOtp.length < 6) {
      setState(() {
        _errorMessage = "Please enter a valid 6-digit OTP.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Call the API service to validate the OTP
      ApiService apiService = ApiService();
      final response = await apiService.verifyOtp(widget.reg_no, flag!);

      if (response['responce'][0]['status'] == "okay" &&
          widget.otp == _enteredOtp) {
        // OTP is valid, navigate to the Sign-In screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(
              message: "Registration successful",
            ),
          ),
        );
      } else {
        setState(() {
          _errorMessage = "Invalid OTP. Please try again.";
          _enteredOtp = ""; // Reset the OTP field when invalid OTP is entered
          otpFieldKey =
              UniqueKey(); // Update the key to rebuild the OtpTextField
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred. Please try again.";
        _enteredOtp = ""; // Reset the OTP field in case of an error
        otpFieldKey = UniqueKey(); // Update the key to rebuild the OtpTextField
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "assets/otp_image.png",
                  width: 200,
                  height: 150,
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Verify",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Enter the OTP we sent to your mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),
              Container(
                key: otpFieldKey, // Assign the unique key to the container
                child: OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.grey,
                  showFieldAsBox: true,
                  onSubmit: (String otp) {
                    setState(() {
                      _enteredOtp = otp; // Store the OTP entered by the user
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 24),
              // Show error message if OTP is invalid
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _validateOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
