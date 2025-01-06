import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/card_payment_screen.dart';

class MakePaymentScreen extends StatefulWidget {
  @override
  _MakePaymentScreenState createState() => _MakePaymentScreenState();
}

class _MakePaymentScreenState extends State<MakePaymentScreen> {
  String selectedAddress = "Home";
  String selectedPaymentMethod = "Debit Card";

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
        title: Text("Make Payment"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery To",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildAddressOption(
              title: "Home",
              subtitle:
                  "Block 10 karvenagar, near Vrindavan garden Pune Kothrud 411038",
            ),
            _buildAddressOption(
              title: "Office",
              subtitle: "Building No 10 Office No 15 Kothrud Pune 411038",
            ),
            SizedBox(height: 20),
            Text(
              "Pay From",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/hdfc.png",
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "***** **** **** 1234",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle change payment method
                    },
                    child: Text(
                      "Change",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Choose mode of transfer",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            _buildPaymentOption("Phone Pay", "assets/phonepe.png"),
            _buildPaymentOption("Google Pay", "assets/googlepay.png"),
            _buildPaymentOption("Debit Card", "assets/visa.png"),
            _buildPaymentOption("Credit Card", "assets/phonepe.png"),
            _buildPaymentOption("Cash On Delivery", "assets/googlepay.png"),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Handle continue action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CardPaymentScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressOption(
      {required String title, required String subtitle}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAddress = title;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: title,
            groupValue: selectedAddress,
            onChanged: (value) {
              setState(() {
                selectedAddress = value!;
              });
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.grey),
            onPressed: () {
              // Handle address edit
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, String iconPath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: title,
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value!;
              });
            },
          ),
          Image.asset(
            iconPath,
            width: 32,
            height: 32,
          ),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
