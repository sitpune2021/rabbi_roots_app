import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Pop the current screen off the navigation stack
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Order Tracking",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Area
          Container(
            height: 200,
            color: Colors.grey[200], // Placeholder for the map
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://via.placeholder.com/600x400.png?text=Map',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Icon(Icons.location_on, color: Colors.red, size: 40),
              ],
            ),
          ),
          // Delivery Information Card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Delivery Partner Information
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/100.png?text=DP',
                          ),
                          radius: 30,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ajit Sharma",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Delivery Partner",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.phone, color: Colors.green),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.chat, color: Colors.green),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Divider(height: 32),
                    // Delivery Time
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Delivery Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text("20 mins"),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Delivery Address
                    Row(
                      children: [
                        Icon(Icons.home, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Delivery Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Block 10, near Vrindavan garden\nKothrud Pune 411038",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          // Close Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                "Close",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
