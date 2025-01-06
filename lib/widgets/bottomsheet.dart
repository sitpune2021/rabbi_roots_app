import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';

void showCartBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Consumer<CartModel>(
        builder: (context, cart, child) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                // Constraining ListView
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Image.network(
                          "https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/de6faf0d-7cd2-4c79-b850-1ab4968df46c.jpg?ts=1708590985",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.product.productName),
                        subtitle: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                cart.decrementQuantity(item.product);
                              },
                            ),
                            Text('Quantity: ${item.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                cart.incrementQuantity(item.product);
                              },
                            ),
                          ],
                        ),
                        trailing:
                            Text('₹${item.product.price * item.quantity}'),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
