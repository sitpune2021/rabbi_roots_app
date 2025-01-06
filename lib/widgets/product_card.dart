import 'package:flutter/material.dart';

// Product model (already defined above)
class ProductGrid extends StatelessWidget {
  final List<Product> products; // Accept a list of products

  ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevent nested scrolling
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Maximum width of each grid item
      ),
      itemCount: products.length, // Use the length of the products list
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image of the product
        Card(
          color: Colors.white,
          child: Image.asset(
            product.imageUrl, // The image URL provided in Product
            width: double.infinity,
            height: 100,
            fit: BoxFit.contain, // Ensure image maintains aspect ratio
          ),
        ),
        const SizedBox(height: 8), // Space between image and text
        // Product name
        Text(
          product.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        // You can add more widgets here (e.g., product price)
      ],
    );
  }
}

class Product {
  final String name;
  final String imageUrl;

  Product({required this.name, required this.imageUrl});
}
