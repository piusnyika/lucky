import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'woocommerce_service.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  bool searchBySKU = false; // Toggle for search option

  void _searchProducts() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        isSearching = true;
      });
      Provider.of<WooCommerceService>(context, listen: false)
          .searchProducts(_searchController.text, searchBy: searchBySKU ? 'sku' : 'name')
          .then((_) {
        setState(() {
          isSearching = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final wooService = Provider.of<WooCommerceService>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by ${searchBySKU ? 'SKU' : 'Name'}',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: _searchProducts,
                    ),
                  ),
                  onSubmitted: (value) => _searchProducts(),
                ),
              ),
              SizedBox(width: 8),
              // Toggle button for searching by SKU or name
              Switch(
                value: searchBySKU,
                onChanged: (value) {
                  setState(() {
                    searchBySKU = value;
                  });
                },
                activeTrackColor: Colors.red,
                activeColor: Colors.white,
              ),
              Text(searchBySKU ? 'SKU' : 'Name'),
            ],
          ),
        ),
        Expanded(
          child: isSearching || wooService.isLoading
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
                      Text("Stock Status: ${product['stock_status']}", style: TextStyle(color: product['stock_status'] == 'instock' ? Colors.blue : Colors.red)),
                      Text("Quantity in Stock: ${product['stock_quantity'] ?? 'N/A'}", style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
