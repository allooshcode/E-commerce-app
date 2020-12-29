import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suria_shop_online/providers/cart.dart';
import 'package:suria_shop_online/screens/drawerapp.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/21.1 badge.dart';
import '../providers/cart.dart';
import 'cartscreen.dart';

enum ShowItims {
  favorite,
  all,
}

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  var _showfav = false;
  var _initData = true;

  @override
  void initState() {
    initDATA();
    // TODO: implement initState
    super.initState();
  }

  var isLoading = true;

  Future<void> initDATA() async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Products>(context, listen: false)
          .fetchandsetitems()
          .then((value) => setState(() {
                isLoading = false;
              }));
      //_initData = false;
    } catch (err) {
      throw err;
    }
  }
  // @override
  // void didChangeDependencies() async {
  //   if (_initData) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     try {
  //       await Provider.of<Products>(context)
  //           .fetchandsetitems()
  //           .then((value) => setState(() {
  //                 isLoading = false;
  //               }));
  //       _initData = false;
  //     } catch (err) {
  //       throw err;
  //     }
  //
  //     // TODO: implement didChangeDependencies
  //     super.didChangeDependencies();
  //   }
  // }

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchandsetitems();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    List<Product> productList =
        _showfav ? productData.favItems : productData.items;

    return Scaffold(
        appBar: AppBar(
          title: Text('suria shop'),
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('Favorite items'),
                    value: ShowItims.favorite,
                  ),
                  PopupMenuItem(
                    child: Text('All'),
                    value: ShowItims.all,
                  )
                ];
              },
              onSelected: (ShowItims value) {
                setState(() {
                  if (value == ShowItims.favorite) {
                    _showfav = true;
                  } else {
                    _showfav = false;
                  }
                });
              },
            ),
            Consumer<Cart>(
              builder: (context, cart, ch) =>
                  Badge(child: ch, value: cart.cartItemCount.toString()),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      CartPage.cartpage,
                    );
                  }),
            )
          ],
        ),
        drawer: DrawerApp(),
        body: RefreshIndicator(
          onRefresh: () {
            return _refreshProducts(context);
          },
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5),
                  itemCount: productList.length,
                  itemBuilder: (context, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ChangeNotifierProvider.value(
                      value: productList[i],
                      child: ProductItem(
                          // title: productList[index].title,
                          // image: './assets/images/suria.png',
                          // id: productList[i].id,
                          ),
                    ),
                  ),
                ),
        ));
  }
}
