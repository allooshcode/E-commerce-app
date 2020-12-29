import 'package:flutter/material.dart';
import 'package:suria_shop_online/screens/manageproducts.dart';
import '../screens/cartscreen.dart';
import '../screens/ordersscrreen.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Details'),
          ),
          ListTile(
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.ordersPage);
            },
          ),
          ListTile(
            title: Text('Manage products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Manage.managepage);
            },
          )
        ],
      ),
    );
  }
}
