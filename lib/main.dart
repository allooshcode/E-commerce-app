import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/providers/order.dart';
import 'package:suria_shop_online/screens/cartscreen.dart';
import 'package:suria_shop_online/screens/edit_screen.dart';
import 'package:suria_shop_online/screens/manageproducts.dart';
import 'package:suria_shop_online/widgets/productmanage.dart';
import './screens/item_details.dart';
import './screens/overview_page.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/ordersscrreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(create: (_) => Order()),
        //ChangeNotifierProvider(create: (_)=>ProductManage(),),
      ],
      child: MaterialApp(
        title: 'suria shop',
        debugShowCheckedModeBanner: false,
        home: OverviewPage(),
        theme: ThemeData(
            fontFamily: 'Lato',
            primarySwatch: Colors.blue,
            accentColor: Colors.amberAccent),
        initialRoute: '/',
        routes: {
          ItemDetails.ItemDetailsPage: (ctx) => ItemDetails(),
          CartPage.cartpage: (ctx) => CartPage(),
          OrdersScreen.ordersPage: (ctx) => OrdersScreen(),
          Manage.managepage: (ctx) => Manage(),
          EditScreen.page: (ctx) => EditScreen(),
        },
      ),
    );
  }
}
