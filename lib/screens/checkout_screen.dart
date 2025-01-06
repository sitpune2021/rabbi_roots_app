import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rabbi_roots/models/cart.dart';
import 'package:rabbi_roots/screens/make_payment_screen.dart';

class CheckoutScreen extends StatelessWidget {
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
            SizedBox(height: 16),
            _buildRecommendedItems(),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItem.product.productName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.grey),
                              onPressed: () {
                                if (cartItem.quantity > 1) {
                                  cart.updateQuantity(
                                      cartItem.product, cartItem.quantity - 1);
                                } else {
                                  cart.removeProduct(cartItem.product);
                                }
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text('${cartItem.quantity}',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline,
                                  color: Colors.grey),
                              onPressed: () {
                                cart.updateQuantity(
                                    cartItem.product, cartItem.quantity + 1);
                              },
                            ),
                          ],
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
            children: [
              _buildRecommendedItem('Besan Atta', '₹250',
                  'https://s3-alpha-sig.figma.com/img/6ba4/0efd/b1c0ff7c1e47be56e17bd1f72cfc1231?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=l4X31XI9L5yfckx0Q8rDzAt2lGIsZ2401~k1LvcaKQe1tlzAwFZcz4sWpslbdmtkVeTi~R5uPdLUtc6kT2ZfwPCOGiO3Q5HOJvhXWBXQ8Wzqaa~9zKsBJbdFezo6qtwla5EU-50K8lKPeQtyFAn-snWB4SWyirqHPK2HmEMqrFNsun8eGqZ6sPg7~CgKG6Qd2cyteeH9BDtgB-5Je~axLD3zStmV7JkwQvt-maMf54J9e5KFBKbVnvCZ9CqvFZg0jziunZAev3NWhF7XmXzMdF4i55V8w0u1Jd3D-XVJwO8XfkKAbr5MykM3rKqntsUedojsbOCEEXeXIg0jHH0BVw__'),
              _buildRecommendedItem('Black Till', '₹125',
                  'https://s3-alpha-sig.figma.com/img/81c6/1b28/d0fb1b18e3f28c5eecbcbf8a464ba0c7?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=FvYWgUCBiPxV-7rSLcM0m4p3AIR384-Kf6HeFDaUvzW70YlvAhsC8nzSXylyUrKQp0UIocK~R82ZitgbzqVhBdT4SdgRF0MrCQXznOa-SkxIjuDo-dhc-Qpq-qnDApd3kDWnFRt184pXyMMT5d3X94yNf4xDV3YH1yQOGY0B0OO42LHvcxr68EGIc1zx55YC9A12VitlRCfVnzWGU4~uxEVQAw3SFvS-2Fmeu5BJlm1zNr5p24P2m6O7MIS9XfVIOkNhX19LlO7axo-v6UEWFADjixe-mdDXH4g4uJ~3UtK6ltIXaf4kGfQSq~KMRSoDdH73vneOPpAdLnJvrRvdSA__'),
            ],
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
