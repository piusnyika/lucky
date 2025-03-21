import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'woocommerce_service.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await Provider.of<WooCommerceService>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final wooService = Provider.of<WooCommerceService>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!wooService.isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          wooService.fetchProducts(loadMore: true);
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: wooService.isLoading && wooService.products.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: wooService.products.length,
              itemBuilder: (context, index) {
                final product = wooService.products[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    title: Text(
                      product['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SKU: ${product['sku']}", style: TextStyle(color: Colors.grey[700])),
                        Text("Price: \$${product['price']}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        Text(
                          "Stock Status: ${product['stock_status']}",
                          style: TextStyle(color: product['stock_status'] == 'instock' ? Colors.blue : Colors.red),
                        ),
                        Text("Quantity in Stock: ${product['stock_quantity'] ?? 'N/A'}", style: TextStyle(fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (wooService.isLoading) LinearProgressIndicator(),
        ],
      ),
    );
  }
}
