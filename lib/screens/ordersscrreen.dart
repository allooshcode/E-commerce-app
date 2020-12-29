import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/screens/drawerapp.dart';

import '../widgets/orderitem.dart' as ordWID;
import '../providers/order.dart';

class OrdersScreen extends StatelessWidget {
  static String ordersPage = 'OrdersScreen';

  @override
  Widget build(BuildContext context) {
    final Order orderContainer = Provider.of<Order>(context);
    final orderlist = orderContainer.orderList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: DrawerApp(),
      body: ListView.builder(
        itemBuilder: (_, i) => ordWID.OrderItem(orderlist[i]),
        itemCount: orderlist.length,
      ),
    );
  }
}
