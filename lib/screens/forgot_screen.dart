import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:rabbi_roots/screens/sign_in_screen.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart'; // For JSON encoding and decoding

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation
  bool _isLoading = false; // To manage loading state

  // Function to validate the mobile number
  String? _validateMobileNumber(String value) {
    String mobileNumber = value.replaceFirst('+91', '').trim();
    if (mobileNumber.length != 10) {
      return 'Mobile number must be exactly 10 digits.';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumber)) {
      return 'Please enter a valid mobile number.';
    }
    if (!['7', '8', '9'].contains(mobileNumber[0])) {
      return 'Mobile number must start with 7, 8, or 9.';
    }
    return null;
  }

  // Function to call the forgot password API
  Future<void> _sendOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    String mobileNumber = _mobileController.text.replaceFirst('+91', '').trim();

    try {
      // Replace this URL with your actual API endpoint
      final url = 'https://rabbiroots.com/APP/forget_password.php';

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'mobile': mobileNumber, // Send mobile number to the API
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Check if the response has the OTP and handle it
        if (responseData['responce'] != null &&
            responseData['responce'].isNotEmpty) {
          String otp = responseData['responce'][0]['otp']; // Extract OTP
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setString('reg_no', responseData['responce'][0]['reg_no']);

          print(prefs.getString('reg_no'));
          print(responseData);

          // Navigate to OTPVerificationScreen with mobile number
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerificationScreen(otp: otp),
            ),
          );
        } else {
          _showErrorDialog('Failed to retrieve OTP. Please try again.');
        }
      } else {
        _showErrorDialog('Failed to send OTP. Please try again.');
      }
    } catch (error) {
      // Handle any network or unexpected errors
      _showErrorDialog('An error occurred. Please try again later.');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          title: Text("Forgot Password"),
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey, // Attach the form key
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "Enter your mobile number associated with your account and we'll send you a WhatsApp OTP to reset your password.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Mobile No. Field with +91 country code and number restriction
                        TextFormField(
                          controller: _mobileController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(
                                13), // Allowing +91 and 10 digits
                          ],
                          validator: (value) {
                            return _validateMobileNumber(value ?? '');
                          },
                          decoration: InputDecoration(
                            labelText: "Mobile No.",
                            prefixText: '+91 ', // Show +91 as a prefix
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Submit Button
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : _sendOTP, // Disable when loading
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE4572E), // Orange color
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : const Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPVerificationScreen extends StatefulWidget {
  final String otp; // OTP received from the backend

  OTPVerificationScreen({required this.otp});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  bool _isLoading = false; // To manage loading state
  String _enteredOtp = ""; // Store the entered OTP
  String? _errorMessage;
  Key otpFieldKey = UniqueKey(); // Unique key for OtpTextField
  TextEditingController _otpController =
      TextEditingController(); // Controller for OTP Text Field

  // Function to validate the OTP
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

    // Simulating an API call or OTP verification
    await Future.delayed(Duration(seconds: 2));

    // Simulate success after OTP validation (replace this with actual API logic)
    bool otpVerified = _enteredOtp == widget.otp;

    setState(() {
      _isLoading = false;
    });

    if (otpVerified) {
      // Navigate to New Password Screen or next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
      );
    } else {
      // Show error if OTP verification fails
      setState(() {
        _enteredOtp = ""; // Reset OTP field if OTP is invalid
        otpFieldKey = UniqueKey(); // Update the key to rebuild the OtpTextField
        _otpController.clear(); // Clear the OTP field text
        _showErrorDialog("Invalid OTP. Please try again.");
      });
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Otp Verification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top image (Logo or related image)
              Center(
                child: Image.asset(
                  "assets/otp_image.png",
                  width: 200,
                  height: 150,
                ),
              ),
              SizedBox(height: 24),

              // Title and description
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
                "Enter the OTP we sent to your mobile number.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 24),

              // OTP Text Field
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

              // Show error message if OTP is invalid
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),

              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: _isLoading ? null : _validateOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE4572E),
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

class NewPasswordScreen extends StatefulWidget {
  NewPasswordScreen({Key? key}) : super(key: key); // OTP passed to the screen

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true; // To toggle password visibility
  bool _isLoading = false; // To manage loading state
  String?
      _passwordMatchError; // To store the "Passwords do not match" error message

  // Function to validate the new password
  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a new password.';
    }
    return null;
  }

  // Function to validate the confirm password
  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != _newPasswordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // Function to update the password via an API call
  Future<void> _updatePassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? regNo = prefs.getString('reg_no');
    print("hi: $regNo");
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      final url =
          'https://rabbiroots.com/APP/resetPass.php'; // Replace with your actual API endpoint

      // Make the POST request with the necessary data (OTP and new password)
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'reg_no': regNo, // OTP entered by user
          'password':
              _newPasswordController.text, // New password entered by user
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // If the request is successful, navigate to the SignInScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      } else {
        // If the request fails, show an error message
        _showErrorDialog('Failed to update password. Please try again.');
      }
    } catch (error) {
      _showErrorDialog('An error occurred. Please try again later.');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  // Function to show an error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to check password matching
  void _checkPasswordsMatch() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordMatchError = 'Passwords do not match';
      });
    } else {
      setState(() {
        _passwordMatchError = null;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Adding listeners to the controllers
    _newPasswordController.addListener(_checkPasswordsMatch);
    _confirmPasswordController.addListener(_checkPasswordsMatch);
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          title: Text("Set New Password"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Form Section for New Password
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Set New Password",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            "Enter the OTP you received and your new password below.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // OTP Field

                        // New Password Field
                        TextFormField(
                          controller: _newPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: "New Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          validator: _validateNewPassword,
                        ),
                        const SizedBox(height: 20),

                        // Confirm Password Field
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: "Confirm Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          validator: _validateConfirmPassword,
                        ),
                        // Display password mismatch error
                        if (_passwordMatchError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _passwordMatchError!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        const SizedBox(height: 50),

                        // Show a loading indicator if the form is submitting
                        if (_isLoading) CircularProgressIndicator(),

                        // Submit Button
                        ElevatedButton(
                          onPressed: _isLoading ? null : _updatePassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE4572E),
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
