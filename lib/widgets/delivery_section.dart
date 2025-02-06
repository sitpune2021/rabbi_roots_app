import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rabbi_roots/screens/location_access_screen2.dart';
import 'package:rabbi_roots/screens/profile/profile_screen.dart';
import 'package:rabbi_roots/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import your API service

class DeliverySection extends StatefulWidget {
  const DeliverySection({Key? key}) : super(key: key);

  @override
  _DeliverySectionState createState() => _DeliverySectionState();
}

class _DeliverySectionState extends State<DeliverySection> {
  loc.Location _location = loc.Location();
  String _currentLocation = "Fetching location...";
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _fetchUserName();
  }

  // Initialize the location service
  Future<void> _initializeLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    // Check if the location service is enabled
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _currentLocation = "Location services are disabled";
        });
        return;
      }
    }

    // Check if the app has location permission
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        setState(() {
          _currentLocation = "Location permission denied";
        });
        return;
      }
    }

    // Fetch the current location
    loc.LocationData _locationData = await _location.getLocation();

    // Use geocoding to get the address from latitude and longitude
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _locationData.latitude!,
      _locationData.longitude!,
    );

    // Extract the address from placemarks (you can customize which fields you want)
    Placemark place = placemarks[0]; // Get the first place in the list
    String address =
        "${place.street}, ${place.locality} ,${place.administrativeArea}";

    // Update the UI with the fetched address
    setState(() {
      _currentLocation = address;
    });
  }

  // Fetch the user's name from the API
  Future<void> _fetchUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? regNo = prefs.getString('reg_no');
    print("hi: $regNo");

    if (regNo != null) {
      try {
        ApiService apiService = ApiService();
        // Fetch user data from the API using reg_no
        final data = await apiService.fetchUserData(regNo);

        // Check if 'responce' key exists
        if (data.containsKey('responce') && data['responce'].isNotEmpty) {
          final user = data['responce'][0];
          print(user);

          // Check if the user is active
          if (user['reg_no'] == regNo) {
            setState(() {
              _userName = user['name'];
            });
          } else {
            print("User account is inactive.");
          }
        } else {
          print("No user data found.");
        }
      } catch (e) {
        // Handle any exceptions during the API call
        print("Failed to fetch user data: ${e.toString()}");
      }
    } else {
      // Existing logic for Google sign-in
      String? userName = prefs.getString('userName');
      String? userEmail = prefs.getString('userEmail');
      String? userPhoto = prefs.getString('userPhoto');
      print("$userPhoto, $userEmail, $userName");

      if (userName != null && userEmail != null && userPhoto != null) {
        setState(() {
          _userName = userName;
        });
      } else {
        print("User data not found in local storage.");
      }
    }
  }

  // Navigate to LocationAccessScreen and receive the selected location
  void _navigateToLocationAccessScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationAccessScreen(),
      ),
    );

    if (result != null && result is LatLng) {
      // Use geocoding to get the address from latitude and longitude
      List<Placemark> placemarks = await placemarkFromCoordinates(
        result.latitude,
        result.longitude,
      );

      Placemark place = placemarks[0];
      String address =
          "${place.street}, ${place.locality} ,${place.administrativeArea}";

      // Update the UI with the selected address
      setState(() {
        _currentLocation = address;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFF06B2D),
                    radius: 25,
                    child: const Icon(Icons.location_on, color: Colors.white),
                  ),
                  const SizedBox(width: 9),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Deliver To',
                        style: TextStyle(
                          color: Color(0xFF056839),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        _currentLocation,
                        style: const TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 9),
                  GestureDetector(
                    onTap:
                        _navigateToLocationAccessScreen, // Call method when the arrow is tapped
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF056839),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Handle tap here
                  // You can navigate to a new screen or perform any other action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  ),
                  radius: 22.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Hello $_userName, Good Afternoon !!',
            style: const TextStyle(
              color: Color(0xFF056839),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
