import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late GoogleMapController mapController;
  late loc.Location _location;
  loc.LocationData? _currentLocation; // Change to nullable
  TextEditingController _addressController = TextEditingController();
  String _locationMessage = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _location = loc.Location();
    _getCurrentLocation();
  }

  // Get current location
  Future<void> _getCurrentLocation() async {
    try {
      loc.LocationData locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
        _locationMessage =
            "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}";
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Failed to get location: $e";
      });
    }
  }

  // Set the map's camera to a given position
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Handle "Enter Location Manually" button click
  void _enterLocationManually() {
    if (_addressController.text.isNotEmpty) {
      // Use geocoding to get coordinates from the manually entered address
      geocodeAddress(_addressController.text);
    }
  }

  // Use geocoding to fetch the coordinates for a given address
  Future<void> geocodeAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        final LatLng newLocation =
            LatLng(locations[0].latitude, locations[0].longitude);
        setState(() {
          _locationMessage = "Manually entered location: $address";
        });
        mapController.animateCamera(CameraUpdate.newLatLng(newLocation));
      }
    } catch (e) {
      setState(() {
        _locationMessage = "Could not find location for the address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Picker"),
      ),
      body: Column(
        children: [
          // Check if _currentLocation is available before displaying the map
          _currentLocation == null
              ? const Center(
                  child:
                      CircularProgressIndicator()) // Show loading indicator if location is being fetched
              : Expanded(
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_currentLocation!.latitude ?? 0.0,
                          _currentLocation!.longitude ?? 0.0),
                      zoom: 14.0,
                    ),
                    markers: {
                      Marker(
                        markerId: MarkerId('current_location'),
                        position: LatLng(
                          _currentLocation!.latitude ?? 0.0,
                          _currentLocation!.longitude ?? 0.0,
                        ),
                      ),
                    },
                  ),
                ),

          // Location message
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(_locationMessage),
          ),

          // Buttons section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _getCurrentLocation,
                  child: const Text("Get Current Location"),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: "Enter Location Manually",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _enterLocationManually,
                  child: const Text("Enter Location Manually"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
