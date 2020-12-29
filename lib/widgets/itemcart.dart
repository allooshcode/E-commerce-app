import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/providers/cart.dart';

class ItemCart extends StatelessWidget {
  final String productID;
  final String namePD;
  final double total;
  final int quantity;

  ItemCart({this.productID, this.namePD, this.total, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Are you sure ?'),
                  content: Text('you want delete item from cart !!'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('yes')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Chip(
                          label: Text('NO'),
                        ))
                  ],
                ));
      },
      key: ValueKey(productID),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).deleteItem(productID);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.all(5),
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        title: Text(namePD),
        subtitle: Text('Total: \$ $total'),
        trailing: Text('${quantity} X'),
        leading: CircleAvatar(
          child: FittedBox(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$$total'),
          )),
          backgroundColor: Colors.amberAccent,
        ),
      ),
    );
  }
}
