import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/providers/order.dart';
import 'package:suria_shop_online/widgets/itemcart.dart';
import '../providers/cart.dart';

class CartPage extends StatelessWidget {
  static String cartpage = 'CartPage';
  @override
  Widget build(BuildContext context) {
    final Cart cartContainer = Provider.of<Cart>(
      context,
    );
    final Order orderContainer = Provider.of<Order>(context, listen: false);

    final List<String> pIds = cartContainer.cartItems.keys.toList();
    final Map<String, CartItem> itemsMap = cartContainer.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('your orders'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              elevation: 5,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Total'),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cartContainer.total.toStringAsFixed(2)}'),
                  ),
                  FlatButton(
                      onPressed: () {
                        orderContainer.addOrder(
                            cartContainer.cartItems.values.toList(),
                            cartContainer.total);
                        cartContainer.deleteCartItems();
                      },
                      child: Text(
                        'Place order',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, i) => Card(
                elevation: 5,
                child: ItemCart(
                  namePD: cartContainer.cartItems.values.toList()[i].name,
                  quantity: itemsMap[pIds[i]].quantity,
                  total: itemsMap[pIds[i]].price * itemsMap[pIds[i]].quantity,
                  productID: pIds[i],
                ),
              ),
              itemCount: cartContainer.cartitemslength,
              padding: EdgeInsets.all(10),
            ),
          )
        ],
      ),
    );
  }
}
