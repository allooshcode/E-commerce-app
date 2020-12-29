import 'package:flutter/material.dart';
import '../providers/product.dart';
import 'package:suria_shop_online/providers/products.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatelessWidget {
  static String ItemDetailsPage = 'ItemDetails';
  // final String id;
  // ItemDetails(this.id);
  @override
  Widget build(BuildContext context) {
    final itemID = ModalRoute.of(context).settings.arguments as String;
    final Product loadedProd =
        Provider.of<Products>(context).fineProdbyID(itemID);
    // final List<Product> productList = productData.items;
    // //
    // final Product descri =
    //     productList.firstWhere((element) => element.id == itemID);
    // final doub
    return Scaffold(
      appBar: AppBar(title: Text('item details')),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            child: Image.network(loadedProd.imageUrl),
            // child: Image.asset('./assets/images/suria.png')
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Chip(label: Text('\$${loadedProd.price}')),
          SizedBox(
            height: 10,
          ),
          Text(
            '${loadedProd.description}',
            softWrap: true,
          )
        ]),
      ),
    );
  }
}
