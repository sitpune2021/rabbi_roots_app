import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String weight;
  final String productName;
  final String deliveryTime;
  final int price;
  final int mrp;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.weight,
    required this.productName,
    required this.deliveryTime,
    required this.price,
    required this.mrp,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void increment(CartModel cart) {
    cart.updateQuantity(
        widget,
        cart.items
                .firstWhere(
                    (item) => item.product.productName == widget.productName)
                .quantity +
            1);
  }

  void decrement(CartModel cart) {
    final currentQuantity = cart.items
        .firstWhere((item) => item.product.productName == widget.productName)
        .quantity;
    if (currentQuantity > 1) {
      cart.updateQuantity(widget, currentQuantity - 1);
    } else {
      cart.removeProduct(widget);
    }
  }

  void addToCart(CartModel cart) {
    cart.addProduct(widget);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        final cartItem = cart.items.firstWhere(
          (item) => item.product.productName == widget.productName,
          orElse: () => CartItem(product: widget, quantity: 0),
        );

        // Get the screen width and height
        double screenWidth = MediaQuery.of(context).size.width;

        // Adjust card width based on screen width
        double cardWidth = screenWidth * 0.45; // 45% of the screen width
        double imageHeight =
            screenWidth * 0.25; // Image height should be 25% of screen width
        double fontSize =
            screenWidth < 600 ? 12 : 14; // Scale text size for smaller screens
        double buttonHeight = 28.0; // Height of the button
        double buttonWidth = 60.0; // Width of the button

        return Container(
          width: cardWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image and Add Button
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Product Image
                  Center(
                    child: Container(
                      height: imageHeight,
                      width: cardWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: widget.imageUrl.startsWith('http')
                              ? NetworkImage(widget.imageUrl)
                              : AssetImage(widget.imageUrl) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  // Add Button or Quantity Control
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: cartItem.quantity > 0
                        ? Container(
                            height: buttonHeight,
                            width: buttonWidth,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () => decrement(cart),
                                  child: Container(
                                    height: buttonHeight,
                                    width: buttonWidth / 3.5,
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.pink,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width: buttonWidth / 3.5,
                                  child: Text(
                                    '${cartItem.quantity}',
                                    style: TextStyle(
                                      fontSize: fontSize + 2,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => increment(cart),
                                  child: Container(
                                    height: buttonHeight,
                                    width: buttonWidth / 3.5,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.pink,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () => addToCart(cart),
                            child: Container(
                              height: buttonHeight,
                              width: buttonWidth,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.pink),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Weight Tag
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.weight,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Product Name
              Text(
                widget.productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize + 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              // Delivery Time
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: Colors.purple),
                  SizedBox(width: 4),
                  Text(
                    widget.deliveryTime,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Price and MRP Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "₹${widget.price}",
                    style: TextStyle(
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "MRP ₹${widget.mrp}",
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.black54,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
