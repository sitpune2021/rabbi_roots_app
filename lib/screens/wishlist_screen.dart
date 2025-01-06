import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  final List<WishlistItem> items = [
    WishlistItem(
      name: "Pasta",
      imageUrl: "assets/pasta.png",
      rating: 4.6,
      totalRatings: 115,
    ),
    WishlistItem(
      name: "Sandwich Bread",
      imageUrl: "assets/sandwich.png",
      rating: 4.1,
      totalRatings: 90,
    ),
    WishlistItem(
      name: "Parley Biscuit",
      imageUrl: "assets/parleg.png",
      rating: 4.5,
      totalRatings: 120,
    ),
    WishlistItem(
      name: "Sunflower Oil",
      imageUrl: "assets/sunflower.png",
      rating: 4.3,
      totalRatings: 51,
    ),
    WishlistItem(
      name: "Oats",
      imageUrl: "assets/oats.png",
      rating: 4.1,
      totalRatings: 524,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Personalized Items Journey Awaits on Wishlist!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Your Favorite's",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                // Navigate to view all items
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return WishlistItemCard(item: items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WishlistItem {
  final String name;
  final String imageUrl;
  final double rating;
  final int totalRatings;

  WishlistItem({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.totalRatings,
  });
}

class WishlistItemCard extends StatelessWidget {
  final WishlistItem item;

  const WishlistItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "${item.rating} (${item.totalRatings}+ rating)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Wishlist Icon
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                // Handle wishlist toggle
              },
            ),
          ],
        ),
      ),
    );
  }
}
