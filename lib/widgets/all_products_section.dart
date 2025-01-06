import 'package:flutter/material.dart';

class AllProductsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                  indent: 20,
                  endIndent: 10,
                ),
              ),
              Text(
                'All Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                  indent: 10,
                  endIndent: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            child: Row(
              children: [
                _buildFilterButton(context, 'Sort', Icons.arrow_drop_down),
                _buildFilterButton(context, 'Fast Delivery', null),
                _buildFilterButton(context, 'Nearest', null),
                _buildFilterButton(context, 'Rating', null),
                _buildFilterButton(context, 'Discounts',
                    null), // Adding more buttons for scrolling
                _buildFilterButton(context, 'Price', null),
                _buildFilterButton(context, 'Popularity', null),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(
      BuildContext context, String label, IconData? icon) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 8.0), // Add some space between buttons
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.orange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          // Define action for button press
        },
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (icon != null) Icon(icon, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
