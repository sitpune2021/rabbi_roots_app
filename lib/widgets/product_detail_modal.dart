import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/checkout_screen.dart';

class ProductCardScreen extends StatefulWidget {
  final String imageUrl;
  final String weight;
  final String productName;
  final String deliveryTime;
  final int price;
  final int mrp;

  const ProductCardScreen({
    Key? key,
    required this.imageUrl,
    required this.weight,
    required this.productName,
    required this.deliveryTime,
    required this.price,
    required this.mrp,
  }) : super(key: key);

  @override
  _ProductCardScreenState createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
  int _quantity = 1;
  int _currentIndex = 0; // To track the current page of the PageView

  // Method to handle quantity increment
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  // Method to handle quantity decrement
  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  // List of image paths
  final List<String> _imageList = [
    'assets/atta.png', // Replace with your actual image assets
    'assets/atta.png', // Example image 2
    'assets/atta.png', // Example image 3
    // Add more images here...
  ];

  // Dot indicator widget
  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _imageList.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? Colors.blue
                : Colors.grey, // Active dot is blue, inactive is grey
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int itemPrice = widget.price; // Use the price passed via constructor
    final int totalPrice = itemPrice * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop(); // Close the screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Horizontal Image Slider (PageView with Dot Indicator)
              Container(
                height: 250, // Adjust height as necessary
                child: PageView.builder(
                  itemCount: _imageList.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex =
                          index; // Update current index on page change
                    });
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Image.asset(
                        _imageList[index],
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              // Dot indicator
              _buildDotIndicator(),
              SizedBox(height: 16),

              // Product Title and Subtitle
              Text(
                widget.productName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.weight,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Card with Brand Info
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: Image.network(
                    widget.imageUrl, // Replace with brand logo asset
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    'Aiwa',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Explore all products',
                    style: TextStyle(color: Colors.green),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Handle navigation
                  },
                ),
              ),
              SizedBox(height: 16),

              // Card with Price and MRP
              Card(
                elevation: 2, // Card shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Discount info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '15% Off',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '₹$itemPrice',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // MRP info
                      Text(
                        'MRP ₹${widget.mrp}',
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Quantity Selector and Add Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Selector
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.grey),
                        onPressed: _decrementQuantity,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$_quantity',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                  // Add Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Handle add item logic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen()),
                      ); // Navigate to Checkout screen
                    },
                    child: Text(
                      'Add Item | ₹$totalPrice',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
