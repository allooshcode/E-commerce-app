import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:suria_shop_online/providers/cart.dart';
import 'package:intl/intl.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> orderItems;
  final DateTime dateTime;
  OrderItem({this.id, this.amount, this.orderItems, this.dateTime});
}

class Order with ChangeNotifier {
  final List<OrderItem> _ordersList = [];

  List<OrderItem> get orderList {
    return [..._ordersList];
  }

  void addOrder(List<CartItem> cartItems, double total) {
    _ordersList.insert(
        0,
        OrderItem(
            id: DateFormat('dd/mm/yy hh:mm').format(DateTime.now()).toString(),
            amount: total,
            dateTime: DateTime.now(),
            orderItems: cartItems));
    notifyListeners();
  }
}
