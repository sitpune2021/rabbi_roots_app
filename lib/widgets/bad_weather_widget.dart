import 'package:flutter/material.dart';

class BadWeatherWidget extends StatefulWidget {
  final bool inParcel;
  const BadWeatherWidget({super.key, this.inParcel = false});

  @override
  State<BadWeatherWidget> createState() => _BadWeatherWidgetState();
}

class _BadWeatherWidgetState extends State<BadWeatherWidget> {
  bool _showAlert = true;
  String? _message;

  @override
  void initState() {
    super.initState();

    // For the purpose of this example, we are simulating zone data here.
    // Replace the logic here with a simpler mechanism.

    // Simulate checking for bad weather condition (you can replace with your own conditions)
    bool weatherConditionMet = true; // Simulate condition (e.g., bad weather)

    if (weatherConditionMet) {
      _showAlert = true;
      _message =
          "Delivery fee may be higher due to bad weather in your area."; // Example message
    } else {
      _showAlert = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showAlert && _message != null && _message!.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  8), // You can change this to your preferred radius
              color: Colors.blue.withOpacity(0.7), // Example color
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: EdgeInsets.symmetric(
              horizontal: widget.inParcel
                  ? 0
                  : 16, // Adjust padding based on `inParcel` flag
              vertical: 24,
            ),
            child: Row(
              children: [
                Icon(Icons.cloud,
                    size: 50, color: Colors.white), // Weather icon example
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _message!,
                    style: TextStyle(
                      fontSize: 16, // Adjust font size
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
