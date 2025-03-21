import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:convert';

class WooCommerceService with ChangeNotifier {
  final String baseUrl = "https://mywebsite.cozw/wp-json/wc/v3";
  final String consumerKey = "ck_consumerkey here";
  final String consumerSecret = "cs_consumer secret key here";

  List products = [];
  bool isLoading = false;
  final Box cacheBox = Hive.box('cacheBox');

  // Fetch products with pagination
  Future<void> fetchProducts({bool loadMore = false}) async {
    // Implement your product fetching logic here
    // For example:
    final url = Uri.parse(
        "$baseUrl/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret");
    try {
      isLoading = true;
      notifyListeners();
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List newProducts = json.decode(response.body);
        products.addAll(newProducts);
        notifyListeners();
      } else {
        throw Exception('Failed to fetch products: ${response.body}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Clear cached data
  void clearCache() {
    cacheBox.clear(); // Clear the cache box
    products.clear(); // Clear the products list
    notifyListeners(); // Notify listeners to update UI
    print('Cache cleared!');
  }

  // Search products by name or SKU
  Future<void> searchProducts(String query, {required String searchBy}) async {
    final String endpoint =
        searchBy == 'sku' ? 'products?sku=$query' : 'products?search=$query';
    final url = Uri.parse(
        "$baseUrl/$endpoint&consumer_key=$consumerKey&consumer_secret=$consumerSecret");

    try {
      isLoading = true;
      notifyListeners();
      final response = await http.get(url);

      if (response.statusCode == 200) {
        products = List<Map<String, dynamic>>.from(json.decode(response.body));
        notifyListeners();
      } else {
        throw Exception('Failed to search products: ${response.body}');
      }
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
