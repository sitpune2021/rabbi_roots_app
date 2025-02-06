import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:rabbi_roots/models/cart.dart';
import 'package:rabbi_roots/widgets/product_card_sub.dart';

class ExploreProducts extends StatefulWidget {
  const ExploreProducts({super.key});

  @override
  State<ExploreProducts> createState() => _ExploreProductsState();
}

class _ExploreProductsState extends State<ExploreProducts> {
  final List<Map<String, dynamic>> products = [
    {
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/76f84dc7-399c-45f2-9c21-bd80f3d07b15.jpg',
      'weight': '500g',
      'productName': 'Product 10',
      'deliveryTime': '2 days',
      'price': 100,
      'mrp': 120,
    },
    {
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/af89f24d-fdd0-45d4-94b0-3de557f962c5.jpg?ts=1723374689',
      'weight': '1kg',
      'productName': 'Product 11',
      'deliveryTime': '1 day',
      'price': 200,
      'mrp': 250,
    },
    {
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/866b948e-e1fd-41a7-bc38-c2b7a8ece6c5.jpg?ts=1715858487',
      'weight': '250g',
      'productName': 'Product 12',
      'deliveryTime': '3 days',
      'price': 50,
      'mrp': 60,
    },
    {
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/3b705d33-4f27-4981-9b67-3516acc1dbd8.jpg?ts=1720505963',
      'weight': '750g',
      'productName': 'Product 13',
      'deliveryTime': '4 days',
      'price': 150,
      'mrp': 170,
    },
    {
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/0a1d4429-4758-480a-8c3e-4f3d12402196.jpg?ts=1718259553',
      'weight': '500g',
      'productName': 'Product 14',
      'deliveryTime': '2 days',
      'price': 90,
      'mrp': 110,
    },
    {
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/865ac5d1-56e9-44a8-8e04-cb73e4c549ea.jpg?ts=1708591123',
      'weight': '1kg',
      'productName': 'Product 15',
      'deliveryTime': '1 day',
      'price': 120,
      'mrp': 140,
    },
  ];

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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cart.items[index];
                        return ListTile(
                          leading: Image.network(
                            item.product.imageUrl,
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
                  Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.white,
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: _buttonStyle(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Close",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore Products',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: 5, end: 5),
                badgeContent: Text(
                  cart.items.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: () {
                    showCartBottomSheet(context);
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of products in a row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.54, // Adjust the aspect ratio as needed
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              imageUrl: product['imageUrl'],
              weight: product['weight'],
              productName: product['productName'],
              deliveryTime: product['deliveryTime'],
              price: product['price'],
              mrp: product['mrp'],
            );
          },
        ),
      ),
    );
  }
}

// class CartScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Cart'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Your Cart',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: Consumer<CartModel>(
//               builder: (context, cart, child) {
//                 return ListView.builder(
//                   itemCount: cart.items.length,
//                   itemBuilder: (context, index) {
//                     final item = cart.items[index];
//                     return ListTile(
//                       leading: Image.network(
//                         item.product.imageUrl,
//                         height: 50,
//                         width: 50,
//                         fit: BoxFit.cover,
//                       ),
//                       title: Text(item.product.productName),
//                       subtitle: Text('Quantity: ${item.quantity}'),
//                       trailing: Text('₹${item.product.price * item.quantity}'),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Close'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
