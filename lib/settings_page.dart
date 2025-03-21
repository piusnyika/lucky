import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'woocommerce_service.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wooService = Provider.of<WooCommerceService>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Settings Page', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              wooService.clearCache();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cache Cleared!')));
            },
            child: Text('Clear Cache'),
          ),
        ],
      ),
    );
  }
}
