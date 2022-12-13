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
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-pro-blue-select?wid=470&hei=556&fmt=png-alpha&.v=1645552346275',
    ),
    Product(
      id: '2',
      title: 'MacBook Pro',
      description: 'Pro Anywhere',
      price: 1299,
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/mbp16-spacegray-select-202110?wid=904&hei=843&fmt=jpeg&qlt=95&.v=1632788574000',
    ),
    Product(
      id: '3',
      title: 'Apple Watch Series 7',
      description: 'Full Screen Ahead',
      price: 399,
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/MKUQ3_VW_34FR+watch-45-alum-midnight-nc-7s_VW_34FR_WF_CO?wid=700&hei=700&trim=1%2C0&fmt=p-jpg&qlt=95&.v=1632171067000%2C1631661671000',
    ),
    Product(
      id: '4',
      title: 'iPad Pro',
      description: 'The Ultimate iPad Experience',
      price: 799,
      imageUrl:
          'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/ipad-pro-12-select-202104_GEO_IN?wid=970&amp;hei=1020&amp;fmt=png-alpha&amp;.v=1617903448000',
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
