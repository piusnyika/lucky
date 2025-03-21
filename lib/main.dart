import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'woocommerce_service.dart';
import 'theme_provider.dart'; // Theme provider for dark mode
import 'home_page.dart';

void main() async {
  await Hive.initFlutter(); // Initialize Hive
  await Hive.openBox('cacheBox'); // Open a box to store cache data
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WooCommerceService()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()), // Add theme provider
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'WooCommerce App',
            theme: ThemeData(
              primaryColor: Colors.red,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              primaryColor: Colors.red,
              brightness: Brightness.dark,
            ),
            themeMode: themeProvider.themeMode, // Toggle between light and dark mode
            home: HomePage(),
            debugShowCheckedModeBanner: false, // Remove debug ribbon
          );
        },
      ),
    );
  }
}
