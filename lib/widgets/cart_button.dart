import 'package:flutter/material.dart';

class AddToCartButton extends StatefulWidget {
  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool isAdded = false; // Track whether the "Add" button is clicked
  int quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 6,
      right: 0,
      child: Container(
        width: 120, // Increased width to fit quantity and buttons
        height: 28,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink),
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: isAdded
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // "-" Button (Decrement)
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.pink,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity--; // Decrease quantity
                        }
                      });
                    },
                  ),
                  // Display quantity
                  Text(
                    '$quantity',
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // "+" Button (Increment)
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.pink,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity++; // Increase quantity
                      });
                    },
                  ),
                ],
              )
            : Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isAdded =
                          true; // When clicked, change to quantity selector
                    });
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
