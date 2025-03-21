# Lucky Product - Flutter WooCommerce App

Lucky Product is a Flutter mobile application that fetches and displays products from a WooCommerce-powered website. The app allows users to browse products, search by name or SKU

## Features

- Fetch products from WooCommerce API
- Infinite scrolling on product listing pages
- Search functionality with SKU and name filter
- Guest user access to browse products
- Admin authentication via Firebase
- Admin features: Add, update, and manage products
- Bottom navigation for Home, Search, Settings, and Login

## Installation

### Prerequisites

- Flutter SDK installed
- Android Studio or Visual Studio Code
- WooCommerce API credentials (Consumer Key & Consumer Secret)

### Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo/lucky.git
   cd lucky-product
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure WooCommerce API:
   Open `lib/woocommerce_service.dart` and update the API details:
   ```dart
   class Config {
    final String baseUrl = "https://mywebsite.cozw/wp-json/wc/v3";
    final String consumerKey = "ck_consumerkey here";
    final String consumerSecret = "cs_consumer secret key here";
   }
   ```
4. Run the app:
   ```sh
   flutter run
   ```

## Dependencies

The app uses the following dependencies:

- `http` A package for making HTTP requests to fetch and send data from APIs.
- `provider` A state management solution for managing app-wide data efficiently.
- `Hive_flutter` A Hive adapter that simplifies integration with Flutter applications.
- `hive` A lightweight, fast NoSQL database for local storage in Flutter apps.
- `shared_preferences ` A simple key-value storage solution for persisting user settings and small data.

## Contributing

Feel free to fork the repository and submit pull requests to enhance the functionality.

## License

This project is licensed under the MIT License.
