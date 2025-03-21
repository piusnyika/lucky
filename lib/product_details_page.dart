import 'package:flutter/material.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['images'][0]['src']),
            SizedBox(height: 16),
            Text('SKU: ${product['sku']}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(product['description'], style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
