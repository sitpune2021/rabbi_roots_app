import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _keepMeSignedIn = false;
  bool _obscurePassword = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Navigate to HomeScreen after login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  void _googleSignInHandler() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print("Signed in with Google: ${account.email}");
        // Navigate to HomeScreen after successful Google Sign-In
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (error) {
      print("Google sign-in failed: $error");
      // Handle error appropriately (e.g., show a dialog)
    }
  }

  void _forgotPassword() {
    // Navigate to Forgot Password screen
    print("Forgot Password tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome back to the app",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _forgotPassword,
                  child: Text("Forgot Password?"),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: _keepMeSignedIn,
                    onChanged: (value) {
                      setState(() {
                        _keepMeSignedIn = value!;
                      });
                    },
                  ),
                  Text("Keep me signed in"),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                child: Text("Log In", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or sign in with"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: _googleSignInHandler,
                icon: Image.asset(
                  'assets/google_icon.png',
                  height: 24,
                  width: 24,
                ),
                label: Text("Continue with Google"),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              // SizedBox(height: 30),
              // Center(
              //   child: TextButton(
              //     onPressed: () {
              //       // Navigate to Create Account screen
              //       print("Create an account tapped");
              //     },
              //     child: Text(
              //       "Create an account",
              //       style: TextStyle(color: Colors.blue),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
