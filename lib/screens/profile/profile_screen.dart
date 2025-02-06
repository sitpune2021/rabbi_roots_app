import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/past_order_screen.dart';
import 'package:rabbi_roots/screens/profile/about/about.dart';
import 'package:rabbi_roots/screens/profile/account_details/account_details.dart';
import 'package:rabbi_roots/screens/profile/customer_care/customer_care.dart';
import 'package:rabbi_roots/screens/profile/manage_addressees/manage_addresses.dart';
import 'package:rabbi_roots/screens/profile/payments_and_refunds/payments_and_refunds.dart';
import 'package:rabbi_roots/screens/profile/ratings_and_reviews/ratings_and_reviews.dart';
import 'package:rabbi_roots/screens/sign_in_screen.dart';
import 'package:rabbi_roots/services/session.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:rabbi_roots/widgets/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userDataFuture;
  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? regNo = prefs.getString('reg_no');
    print("hi: $regNo");

    if (regNo != null) {
      try {
        // Fetch user data from the API using reg_no
        final data = await apiService.fetchUserData(regNo);

        // Check if 'responce' key exists
        if (data.containsKey('responce') && data['responce'].isNotEmpty) {
          final user = data['responce'][0];
          print(user);

          // Check if the user is active
          if (user['reg_no'] == regNo) {
            return {
              "status": "okay",
              "data": {
                "name": user['name'] ?? '', // Provide default value
                "email": user['email'] ?? '', // Provide default value
                "mobile": user['mobile_no'] ?? '', // Provide default value
                "profileImageUrl": user['profileImageUrl'] ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png', // Use default URL if not available
              }
            };
          } else {
            return {"status": "error", "message": "User account is inactive."};
          }
        } else {
          return {"status": "error", "message": "No user data found."};
        }
      } catch (e) {
        // Handle any exceptions during the API call
        return {
          "status": "error",
          "message": "Failed to fetch user data: ${e.toString()}"
        };
      }
    } else {
      // Existing logic for Google sign-in
      String? userName = prefs.getString('userName');
      String? userEmail = prefs.getString('userEmail');
      String? userPhoto = prefs.getString('userPhoto');
      print("$userPhoto, $userEmail, $userName");

      if (userName != null && userEmail != null && userPhoto != null) {
        return {
          "status": "okay",
          "data": {
            "name": userName,
            "email": userEmail,
            "profileImageUrl": userPhoto,
            "mobile": "", // Default value for mobile number
          }
        };
      } else {
        return {
          "status": "error",
          "message": "User data not found in local storage."
        };
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData && snapshot.data!['status'] == 'okay') {
            final userData = snapshot.data!['data'];
            return _buildProfileContent(
              context,
              userData['name'],
              userData['email'],
              userData['profileImageUrl'],
              userData['mobile'],
            );
          } else {
            return Center(
                child: Text(
                    snapshot.data?['message'] ?? "Failed to load user data"));
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, String name, String email,
      String profileImageUrl, String mobile) {
    String defaultImageUrl =
        'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'; // Replace with your default image URL

    return CustomScrollView(
      slivers: [
        // Profile Header Section - Non-scrollable header
        SliverToBoxAdapter(
          child: ProfileHeader(
            name: name,
            email: email,
            profileImageUrl:
                profileImageUrl.isNotEmpty ? profileImageUrl : defaultImageUrl,
          ),
        ),
        // Profile Options Section - Scrollable list
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildProfileOption(Icons.info, 'About', AboutScreen(), context),
              _buildProfileOption(
                  Icons.person,
                  'Account Details',
                  AccountDetailsScreen(
                      name: name,
                      email: email,
                      profileImageUrl: profileImageUrl,
                      mobile: mobile), // Pass mobile number here
                  context),
              _buildProfileOption(Icons.shopping_bag, 'Your Orders',
                  PastOrdersScreen(), context),
              _buildProfileOption(Icons.location_on, 'Manage Addresses',
                  ManageAddressesScreen(), context),
              _buildProfileOption(Icons.payment, 'Payments & Refunds',
                  PaymentsAndRefundsScreen(), context),
              _buildProfileOption(Icons.star, 'Ratings and Reviews',
                  RatingsAndReviewsScreen(), context),
              _buildProfileOption(Icons.support_agent, 'Customer Care',
                  CustomerCareScreen(), context),
              _buildProfileOption(
                  Icons.logout,
                  'Logout',
                  SignInScreen(
                    message: "Logged out successfully", // Pass the message here
                    messageColor: Colors.red,
                  ),
                  context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(
      IconData icon, String title, Widget screen, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade100,
        child: Icon(
          icon,
          color: Colors.green,
        ),
      ),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        if (title == "Logout") {
          showLogoutDialog(context);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        }
      },
    );
  }
}

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: const Text('Log out'),
            onPressed: () async {
              await Session.logout();
              Navigator.of(context).pop(); // Dismiss the dialog
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => SignInScreen(
                    message: "Logged out successfully",
                    messageColor: Colors.red, // Pass the message here
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      );
    },
  );
}
