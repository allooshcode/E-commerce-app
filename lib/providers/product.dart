import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String description;
  final String imageUrl;
  bool isFavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.description,
      @required this.imageUrl,
      this.isFavorite = false});

  List<Product> favoList = [];

  void manfavoriteList(Product item) {
    isFavorite = !isFavorite;
    if (isFavorite) {
      favoList.add(item);
    } else {
      favoList.remove(item);
    }
    notifyListeners();
  }
}
