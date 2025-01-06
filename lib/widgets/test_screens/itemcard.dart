import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final bool isPopularItem;
  final bool isFood;
  final bool isShop;
  final bool isPopularItemCart;
  final int? index;
  const ItemCard({
    Key? key,
    required this.item,
    this.isPopularItem = false,
    required this.isFood,
    required this.isShop,
    this.isPopularItemCart = false,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? discount =
        item.storeDiscount == 0 ? item.discountedPrice : item.storeDiscount;
    String? discountType =
        item.storeDiscount == 0 ? item.discountType : 'percent';

    return MouseRegion(
      onEnter: (_) {}, // Placeholder for hover effect
      onExit: (_) {},
      child: Stack(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).cardColor,
            ),
            child: InkWell(
              onTap: () {
                // Navigate to item page
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => ItemPage(item: item)));
              },
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(isPopularItem ? 4.0 : 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                              bottomLeft:
                                  Radius.circular(isPopularItem ? 16 : 0),
                              bottomRight:
                                  Radius.circular(isPopularItem ? 16 : 0),
                            ),
                            child: Image.network(
                              item.imageFullUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Halal Tag
                        if (item.isStoreHalalActive! && item.isHalalItem!)
                          Positioned(
                            top: 40,
                            right: 15,
                            child: Image.asset(
                              'assets/halal_tag.png',
                              height: 20,
                              width: 20,
                            ),
                          ),

                        // Discount Tag
                        if (discount > 0)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Chip(
                              label: Text(
                                '$discountType $discount%',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          ),

                        // Out of Stock
                        if (item.stock != null && item.stock! < 1)
                          Positioned(
                            bottom: 10,
                            left: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Out of Stock',
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                        // Cart Count (only for non-shops)
                        if (!isShop)
                          Positioned(
                            bottom: 10,
                            right: 20,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                item.cartCount.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Item Information
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: isShop ? 0 : 8.0,
                        top: 8.0,
                        bottom: isShop ? 0 : 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: isPopularItem
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          if (isFood || isShop)
                            Text(
                              item.storeName ?? '',
                              style: TextStyle(
                                  color: Theme.of(context).disabledColor),
                            ),
                          if (!(isFood || isShop))
                            Text(
                              item.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          if (item.ratingCount > 0)
                            Row(
                              mainAxisAlignment: isPopularItem
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  item.avgRating!.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "(${item.ratingCount})",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).disabledColor),
                                ),
                              ],
                            ),
                          if (discount > 0)
                            Text(
                              '\$${item.originalPrice}', // Show crossed price
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                          Text(
                            '\$${item.discountedPrice}', // Show discounted price
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Sample Item Model (replace with actual model)
class Item {
  final String imageFullUrl;
  final String name;
  final String? storeName;
  final double discountedPrice;
  final double originalPrice;
  final double? avgRating;
  final int ratingCount;
  final int? stock;
  final int cartCount;
  final bool? isStoreHalalActive;
  final bool? isHalalItem;
  final double storeDiscount;
  final String discountType;

  Item({
    required this.imageFullUrl,
    required this.name,
    required this.storeName,
    required this.discountedPrice,
    required this.originalPrice,
    required this.avgRating,
    required this.ratingCount,
    required this.stock,
    required this.cartCount,
    this.isStoreHalalActive,
    this.isHalalItem,
    required this.storeDiscount,
    required this.discountType,
  });
}
