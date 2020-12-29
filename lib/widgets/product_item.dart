import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/providers/cart.dart';
import 'package:suria_shop_online/providers/product.dart';
import '../screens/item_details.dart';

class ProductItem extends StatelessWidget {
  // final String title;
  // final String image;
  // final String id;
  //
  // ProductItem({this.title, this.image, this.id});

  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ItemDetails.ItemDetailsPage,
          arguments: productItem.id,
        );
      },
      child: GridTile(
        child: Image.network(
          productItem.imageUrl,
          fit: BoxFit.cover,
        ),
        // child: Image.asset(
        //   './assets/images/suria.png',

        footer: GridTileBar(
          title: Text(productItem.title),
          subtitle: Text('بضاعة عربية جديدة'),
          leading: Consumer<Product>(
            builder: (context, productItem, child) => IconButton(
              //padding: EdgeInsets.all(2),
              onPressed: () {
                productItem.manfavoriteList(productItem);
                print(productItem.favoList);
              },
              icon: productItem.isFavorite
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItemCart(
                  productItem.id, productItem.title, productItem.price);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text('Item added'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removesingleItem(productItem.id);
                  },
                ),
              ));
            },
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
