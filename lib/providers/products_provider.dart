import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: '1',
      title: 'iPhone 13 Pro',
      description: 'Oh So Pro',
      price: 999,
      imageUrl: 'https://m.media-amazon.com/images/I/61jLiCovxVL._SL1500_.jpg',
    ),
    Product(
      id: '2',
      title: 'MacBook Pro',
      description: 'Pro Anywhere',
      price: 1299,
      imageUrl: 'https://m.media-amazon.com/images/I/61aUBxqc5PL._SL1500_.jpg',
    ),
    Product(
      id: '3',
      title: 'Apple Watch Series 7',
      description: 'Full Screen Ahead',
      price: 399,
      imageUrl: 'https://m.media-amazon.com/images/I/71W+RrSPINL._SL1500_.jpg',
    ),
    Product(
      id: '4',
      title: 'iPad Pro',
      description: 'The Ultimate iPad Experience',
      price: 799,
      imageUrl: 'https://m.media-amazon.com/images/I/81hAx31maUL._SL1500_.jpg',
    ),
  ];

  // var _showFavourites = false;

  List<Product> get items {
    // if (_showFavourites) {
    //   return _items.where((prodItem) => prodItem.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavourites() {
  //   _showFavourites = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavourites = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final url = Uri.parse(
        'https://e-commerce-app-6221e-default-rtdb.firebaseio.com/products_provider.json');
    http.post(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }));
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); //inserts at start of the list
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print(prodIndex);
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
