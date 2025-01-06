import 'package:flutter/material.dart';

class PaymentsAndRefundsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payments and Refunds',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _buildTransactionItem(transaction);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Transaction details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['date'],
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          // Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction['amount'],
                style: TextStyle(
                  color: transaction['type'] == 'refund'
                      ? Colors.green
                      : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction['status'],
                style: TextStyle(
                  color: transaction['status'] == 'Completed'
                      ? Colors.green
                      : Colors.orange,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Sample transaction data
final List<Map<String, dynamic>> transactions = [
  {
    'title': 'Order #1234',
    'date': 'Dec 18, 2024',
    'amount': '\$100.00',
    'status': 'Completed',
    'type': 'payment',
  },
  {
    'title': 'Refund #5678',
    'date': 'Dec 17, 2024',
    'amount': '\$50.00',
    'status': 'Refunded',
    'type': 'refund',
  },
  {
    'title': 'Order #2345',
    'date': 'Dec 15, 2024',
    'amount': '\$200.00',
    'status': 'Pending',
    'type': 'payment',
  },
  {
    'title': 'Refund #3456',
    'date': 'Dec 14, 2024',
    'amount': '\$20.00',
    'status': 'Refunded',
    'type': 'refund',
  },
];

void main() => runApp(MaterialApp(
      home: PaymentsAndRefundsScreen(),
    ));
