import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/providers/products.dart';
import 'package:suria_shop_online/screens/drawerapp.dart';
import 'package:suria_shop_online/screens/edit_screen.dart';
import '../widgets/productmanage.dart';

class Manage extends StatelessWidget {
  static String managepage = 'Manage';
  bool isLoaded = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Products productcontainer = Provider.of<Products>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditScreen.page)
                  .then((value) => isLoaded = value);
            },
          )
        ],
      ),
      drawer: DrawerApp(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView.builder(
            itemBuilder: (ctx, i) => ProductManage(
                productcontainer.items[i].title,
                productcontainer.items[i].imageUrl,
                productcontainer.items[i].id,
                _scaffoldKey.currentContext),
            itemCount: productcontainer.items.length,
          ),
        ),
      ),
    );
  }
}
