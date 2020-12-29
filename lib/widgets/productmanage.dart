import 'package:flutter/material.dart';
import 'package:suria_shop_online/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductManage extends StatelessWidget {
  final String name;
  final String url;
  final String id;
  final BuildContext _scaffoldKey;
  ProductManage(this.name, this.url, this.id, this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    final samecontex = context;

    final scaffold = Scaffold.of(context);
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(url),
            //backgroundImage: AssetImage('./assets/images/suria.png'),
          ),
          title: Text(name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditScreen.page, arguments: id);
                  }),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    return showDialog(
                      context: _scaffoldKey,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure '),
                        content: Text('you want delete item ?'),
                        actions: [
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: Text('yes')),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text('no'))
                        ],
                      ),
                    ).then((value) async {
                      if (value) {
                        try {
                          await Provider.of<Products>(context, listen: false)
                              .deleteItem(id);
                        } catch (error) {
                          // return scaffold.showSnackBar(
                          //     SnackBar(content: Text('deleting failed')));
                          return showDialog(
                              context: _scaffoldKey,
                              builder: (ctx) => AlertDialog(
                                    title: Text(error.toString()),
                                    content: Text('item not deleted'),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(_scaffoldKey).pop();
                                          },
                                          child: Text('OK')),
                                    ],
                                  ));
                        }
                      }
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
