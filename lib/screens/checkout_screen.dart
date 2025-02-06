import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';
import 'package:rabbi_roots/screens/make_payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, String>> recommendedProducts = [
    {
      'name': 'Besan Atta',
      'price': '₹250',
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/17d8619a-a1d3-45e3-bf74-a1208374df8f.jpg?ts=1707312305',
    },
    {
      'name': 'Black Tea',
      'price': '₹125',
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/fd1c4990-9ed7-4bc8-8f62-6cea02472901.jpg?ts=1725262957',
    },
    {
      'name': 'Green Tea',
      'price': '₹200',
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/large_images/jpeg/a691b3f6-4c9a-4331-ad98-884a6fa177f4.jpg?ts=1710350833',
    },
    {
      'name': 'Basmati Rice',
      'price': '₹300',
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/0699b926-fc76-4a6e-9553-98dc7ee21b1a.jpg?ts=1723799645',
    },
    {
      'name': 'Olive Oil',
      'price': '₹500',
      'imageUrl':
          'https://cdn.grofers.com/cdn-cgi/image/f=auto,fit=scale-down,q=70,metadata=none,w=270/app/assets/products/sliding_images/jpeg/f65471ae-7636-46f9-9ab6-888578efd738.jpg?ts=1718259559',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Rabbi Roots',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeliveryInfo(),
            SizedBox(height: 16),
            _buildCartItems(context),
            // SizedBox(height: 16),
            // _buildRecommendedItems(),
            SizedBox(height: 16),
            _buildOffersAndBenefits(),
            SizedBox(height: 16),
            _buildDeliveryInstructions(),
            SizedBox(height: 16),
            _buildPriceDetails(context),
            SizedBox(height: 16),
            _buildProceedToPayButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.home, color: Colors.green),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('20 mins to home',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Block 10 karvenagar...',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
        Icon(Icons.arrow_drop_down),
      ],
    );
  }

  Widget _buildCartItems(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return Column(
          children: cart.items.map((cartItem) {
            return Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          cartItem.product.imageUrl,
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItem.product.productName,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle_outline,
                                        color: Colors.grey),
                                    onPressed: () {
                                      if (cartItem.quantity > 1) {
                                        cart.updateQuantity(cartItem.product,
                                            cartItem.quantity - 1);
                                      } else {
                                        cart.removeProduct(cartItem.product);
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text('${cartItem.quantity}',
                                        style: TextStyle(fontSize: 16)),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add_circle_outline,
                                        color: Colors.grey),
                                    onPressed: () {
                                      cart.updateQuantity(cartItem.product,
                                          cartItem.quantity + 1);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text('₹${cartItem.product.price * cartItem.quantity}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildRecommendedItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('You may like to add',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: recommendedProducts.map((product) {
              return _buildRecommendedItem(
                product['name']!,
                product['price']!,
                product['imageUrl']!,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildOffersAndBenefits() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Offers and Benefits',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('₹80 off',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Flat deal | Above ₹399',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Icon(Icons.percent, color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Delivery Instructions',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDeliveryInstruction(
                'Avoid ringing bell', Icons.notifications_off),
            _buildDeliveryInstruction(
                'Leave at the door', Icons.door_back_door),
            _buildDeliveryInstruction('Leave with security', Icons.security),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceDetails(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        final total = cart.items.fold(
          0,
          (sum, item) => sum + item.product.price * item.quantity,
        );
        final deliveryFee = 30;
        final taxes = 20;
        final discount = total > 399 ? 80 : 0;
        final grandTotal = total + deliveryFee + taxes - discount;

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPriceDetail('Item Total', '₹$total'),
                _buildPriceDetail('Delivery fee', '₹$deliveryFee'),
                _buildPriceDetail('Taxes', '₹$taxes'),
                _buildPriceDetail('Discount', '-₹$discount', isDiscount: true),
                Divider(color: Colors.grey, height: 24),
                _buildPriceDetail('Total', '₹$grandTotal', isTotal: true),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProceedToPayButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MakePaymentScreen()),
          );
        },
        child: Text('Proceed To Pay',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildRecommendedItem(String name, String price, String imageUrl) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(price, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Icon(Icons.add_circle, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildDeliveryInstruction(String text, IconData icon) {
    return Container(
      width: 120, // Set a fixed width for each item
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12), // Adjust text size as needed
          ),
        ],
      ),
    );
  }

  Widget _buildPriceDetail(String label, String value,
      {bool isDiscount = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : null,
              color: isDiscount ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
