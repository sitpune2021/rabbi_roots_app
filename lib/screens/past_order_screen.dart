import 'package:flutter/material.dart';

class PastOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Orders'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                OrderCard(
                  title: "Aiwa Multigrain Atta",
                  location: "karvenagar",
                  price: "₹180",
                  date: "March 4",
                  time: "11:50 PM",
                ),
                OrderCard(
                  title: "Bread & Pasta",
                  location: "Kothrud",
                  price: "₹450",
                  date: "February 24",
                  time: "04:25 PM",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String date;
  final String time;

  const OrderCard({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: const [
                    Text(
                      "Delivered",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(location,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            Text("$date  $time",
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderAction(
                  label: "Rate the Order Experience",
                  color: Colors.green,
                  icon: Icons.arrow_forward,
                ),
                OrderAction(
                  label: "Rate delivery boy",
                  color: Colors.orange,
                  icon: Icons.arrow_forward,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderAction extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const OrderAction({
    Key? key,
    required this.label,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: color)),
        const SizedBox(width: 8),
        Icon(icon, size: 16, color: color),
      ],
    );
  }
}
