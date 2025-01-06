import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';
import 'package:rabbi_roots/screens/sign_in_screen.dart';
import 'package:rabbi_roots/screens/splash_screens/splash_screen.dart';
import 'package:rabbi_roots/screens/splash_screens/splash_screen_1.dart';
import 'package:rabbi_roots/screens/home_screen.dart';
import 'package:rabbi_roots/services/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: ChangeNotifierProvider(
        create: (context) =>
            ConnectivityService(), // Add ConnectivityService here
        child: MyApp(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home: SplashScreen(
        isLoggedIn: isLoggedIn,
      ),
      routes: {
        '/login': (context) => SignInScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}

class SplashScreenHandler extends StatefulWidget {
  @override
  _SplashScreenHandlerState createState() => _SplashScreenHandlerState();
}

class _SplashScreenHandlerState extends State<SplashScreenHandler> {
  @override
  void initState() {
    super.initState();

    // Simulate a delay to show splash screen
    Future.delayed(Duration(seconds: 3), () {
      _checkAuthentication();
    });
  }

  void _checkAuthentication() async {
    final User? user = FirebaseAuth.instance.currentUser;

    // If the user is authenticated, navigate to HomeScreen
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // If the user is not authenticated, navigate to SignInScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnboardingScreen(); // Show the splash screen
  }
}
