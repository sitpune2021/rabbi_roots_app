import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/otp_verification_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _otp;
  String? _reg_no;

  final ApiService _apiService = ApiService();

  // Error messages for validation
  String? _nameError;
  String? _emailError;
  String? _mobileError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Lists to store registered emails and mobile numbers
  Set<String> _registeredEmails = {};
  Set<String> _registeredMobileNumbers = {};

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchRegisteredUsers();

    // Add listeners to email and mobile number fields for real-time validation
    _emailController.addListener(_validateEmail);
    _mobileController.addListener(_validateMobile);

    // Add listener to confirm password field to check for matching passwords
    _passwordController.addListener(_validatePasswordMatch);
    _confirmPasswordController.addListener(_validatePasswordMatch);
  }

  // Fetch registered emails and mobile numbers
  Future<void> _fetchRegisteredUsers() async {
    try {
      final response = await _apiService.fetchRegisteredUsers();
      setState(() {
        final List<dynamic> users = response['responce'];

        // Store emails in lowercase and trimmed
        _registeredEmails = users
            .map<String>(
                (user) => user['email'].toString().trim().toLowerCase())
            .where((email) => email.isNotEmpty)
            .toSet();

        // Store mobile numbers trimmed
        _registeredMobileNumbers = users
            .map<String>((user) => user['mobile_no'].toString().trim())
            .where((mobile) => mobile.isNotEmpty)
            .toSet();
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Failed to load registered users. Please try again later.';
      });
    }
  }

  // Validate email
  void _validateEmail() {
    String emailInput = _emailController.text.trim().toLowerCase();
    if (emailInput.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(emailInput)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
    } else if (_registeredEmails.contains(emailInput)) {
      setState(() {
        _emailError = 'This email is already registered';
      });
    } else {
      setState(() {
        _emailError = null; // Clear error if valid
      });
    }
  }

  // Validate mobile number
  void _validateMobile() {
    String mobileInput = _mobileController.text.trim();

    // Ensure that the mobile number is exactly 10 digits and contains only digits
    if (mobileInput.isEmpty ||
        mobileInput.length != 10 ||
        !RegExp(r'^\d{10}$').hasMatch(mobileInput)) {
      setState(() {
        _mobileError = 'Please enter exactly 10 digits';
      });
    } else if (_registeredMobileNumbers.contains(mobileInput)) {
      setState(() {
        _mobileError = 'This mobile number is already registered';
      });
    } else {
      setState(() {
        _mobileError = null; // Clear error if valid
      });
    }
  }

  // Validate password and confirm password match
  void _validatePasswordMatch() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (confirmPassword.isNotEmpty && password != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Passwords do not match';
      });
    } else {
      setState(() {
        _confirmPasswordError = null; // Clear error if passwords match
      });
    }
  }

  // Validate all inputs when user presses Sign Up
  bool _validateInputs() {
    bool isValid = true;

    setState(() {
      _nameError = null;
      _emailError = null;
      _mobileError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _errorMessage = null;
    });

    // Validate name
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = 'Please enter your name';
      });
      isValid = false;
    }

    // Validate password
    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters long';
      });
      isValid = false;
    }

    return isValid;
  }

  // Sign-up method
  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Validate inputs
    if (!_validateInputs()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Call the sign-up API
    final response = await _apiService.signUp(
      _nameController.text,
      _emailController.text,
      _mobileController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    // Handle the API response
    if (response['responce'][0]['status'] == 'okay') {
      setState(() {
        _otp = response['responce'][0]['otp']; // Extract OTP from response
        _reg_no = response['responce'][0]['reg_no'];
        _errorMessage = null;
      });

      // Navigate to OTP Verification Screen after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            otp: _otp!,
            mobileNo: _mobileController.text,
            reg_no: _reg_no!,
          ),
        ),
      );
    } else {
      setState(() {
        _errorMessage = response['responce'][0]['status'] ??
            'An error occurred, please try again.';
        _otp = null;
        _reg_no = null;
      });
    }
  }

  @override
  void dispose() {
    _emailController.removeListener(_validateEmail);
    _mobileController.removeListener(_validateMobile);
    _passwordController.removeListener(_validatePasswordMatch);
    _confirmPasswordController.removeListener(_validatePasswordMatch);
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top image
              Stack(
                children: [
                  Image.asset(
                    'assets/sign_up.png',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),

              // Form Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sign Up Text
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Name Field
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          errorText: _nameError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Email Field
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email-id",
                          errorText: _emailError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Mobile Field
                      TextField(
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: "Mobile No.",
                          errorText: _mobileError,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          errorText: _passwordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Confirm Password Field
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          errorText: _confirmPasswordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Error message if any
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                      // OTP message if sign-up is successful
                      if (_otp != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'OTP: $_otp',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                      // Sign-Up Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE4572E),
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Center(
                                child: Text(
                                  "Sign Up",
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
