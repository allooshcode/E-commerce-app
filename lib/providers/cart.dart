import 'dart:io';

import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem(
      {@required this.id,
      @required this.name,
      @required this.price,
      this.quantity = 0});
}

class Cart extends ChangeNotifier {
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get cartitemslength {
    return _cartItems.length;
  }

  int get cartItemCount {
    int count = 0;
    _cartItems.forEach((key, value) {
      count += value.quantity;
    });
    return count;
  }

  double get total {
    double total = 0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });

    return total;
  }

  void addItemCart(
    String productID,
    String name,
    double price,
  ) {
    _cartItems.putIfAbsent(
        productID,
        () =>
            CartItem(id: DateTime.now().toString(), name: name, price: price));
    if (_cartItems.containsKey(productID)) {
      _cartItems.update(productID, (existingCartitem) {
        return CartItem(
            id: existingCartitem.id,
            name: existingCartitem.name,
            price: existingCartitem.price,
            quantity: existingCartitem.quantity + 1);
      });
    }

    notifyListeners();
  }

  void deleteItem(String pID) {
    _cartItems.remove(pID);
    notifyListeners();
  }

  void removesingleItem(String pid) {
    if (!cartItems.containsKey(pid)) {
      return;
    }
    if (cartItems[pid].quantity > 1) {
      cartItems[pid].quantity -= 1;
    } else {
      deleteItem(pid);
    }
    notifyListeners();
  }

  void deleteCartItems() {
    _cartItems.clear();
    notifyListeners();
  }
}
