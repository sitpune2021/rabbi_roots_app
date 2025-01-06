import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '12:30',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            fontFamily: 'Roboto',
          ),
        ),
        Row(
          children: [
            Icon(Icons.signal_cellular_alt, size: 24),
            SizedBox(width: 4),
            Icon(Icons.wifi, size: 24),
            SizedBox(width: 4),
            Icon(Icons.battery_full, size: 24),
          ],
        ),
      ],
    );
  }
}
