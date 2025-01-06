import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rabbi_roots/screens/forgot_screen.dart';
import 'package:rabbi_roots/screens/sign_up_screen.dart';
import 'package:rabbi_roots/screens/home_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';

class SignInScreen extends StatefulWidget {
  final String? message;
  final Color? messageColor;

  SignInScreen({this.message, this.messageColor});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _keepMeSignedIn = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.message != null) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Expanded(child: Text(widget.message!)),
              ],
            ),
            backgroundColor: widget.messageColor ?? Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      });
    }
  }

  // Handle Login Button
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      try {
        ApiService apiService = ApiService();
        final response = await apiService.signin(username, password);

        if (response['responce'][0]['status'] == "okay") {
          // Store login state and user info
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLoggedIn', true);
          prefs.setString('reg_no', response['responce'][0]['reg_no']);

          print(prefs.getString('reg_no'));

          // Navigate to HomeScreen after successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomeScreen(message: "Signed in successfully"),
            ),
          );
        } else {
          _showErrorDialog("Invalid username or password. Please try again.");
        }
      } catch (e) {
        _showErrorDialog("An error occurred. Please try again.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  // Handle Forgot Password
  void _forgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotScreen()),
    );
  }

  // Handle Google Sign-In
  Future<void> _googleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Create an instance of GoogleSignIn
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Attempt to sign in the user
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in
        _showErrorDialog("Google Sign-In was canceled.");
        return;
      }

      // Print account details
      print("Google User ID: ${googleUser.id}");
      print("Google User Email: ${googleUser.email}");
      print("Google User Display Name: ${googleUser.displayName}");
      print("Google User Photo URL: ${googleUser.photoUrl}");

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google [UserCredential]
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        // Print Firebase user details
        print("Firebase User ID: ${user.uid}");
        print("Firebase User Email: ${user.email}");
        print("Firebase User Display Name: ${user.displayName}");
        print("Firebase User Photo URL: ${user.photoURL}");

        // Store login state and user info
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', user.uid);
        prefs.setString('userName', user.displayName ?? '');
        prefs.setString('userEmail', user.email ?? '');
        prefs.setString('userPhoto', user.photoURL ?? '');

        // Navigate to HomeScreen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(message: "Signed in successfully"),
          ),
        );
      }
    } catch (e) {
      _showErrorDialog(
          "An error occurred during Google Sign-In. Please try again.");
      print("Google Sign-In Error: $e"); // For debugging purposes
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFFE4572E), // Orange background color
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset("assets/rabbiroots.png"),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Sign-In Text
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Username Field
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  // Remember Me and Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          Text("Remember me"),
                        ],
                      ),
                      TextButton(
                        onPressed: _forgotPassword,
                        child: Text("Forget Password?"),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE4572E), // Orange color
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 20),

                  // Sign-In with Google Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _googleSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.black)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/google_icon.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 20),

                  // Sign-Up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
