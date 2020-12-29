import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suria_shop_online/providers/products.dart';
import '../providers/product.dart';

class EditScreen extends StatefulWidget {
  static String page = 'EditScreen';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _imageController = TextEditingController();
  final _focusImage = FocusNode();
  final _focusprice = FocusNode();
  //final _titlefocus = FocusNode();
  final _golbalkey = GlobalKey<FormState>();
  Product _editedProduct = Product(
      id: null,
      title: null,
      price: 0,
      description: null,
      imageUrl: null,
      isFavorite: false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _focusImage.addListener(() {
      _updateImage();
    });
    super.initState();
  }

  void _updateImage() {
    if (!_focusImage.hasFocus) {
      if (_imageController.text.isEmpty ||
          (!_imageController.text.startsWith('http') &&
              !_imageController.text.startsWith('https'))) {
        return;
      }
      //print('this is state of image');
      setState(() {});
    }
  }

  var isLoading = false;
  Future<void> _saveinfo() async {
    final isValid = _golbalkey.currentState.validate();
    if (!isValid) {
      return;
    }

    _golbalkey.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (_editedProduct.id != null) {
      try {
        await Provider.of<Products>(context, listen: false)
            .updateItem(_editedProduct.id, _editedProduct);
      } catch (err) {
        await showDialog<Null>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          ),
        );
      }
      //Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
    }
    setState(() {
      isLoading = false;
      Navigator.of(context).pop();
    });

    // then((value) {
  }

  // print(_editedProduct.title);
  // print(_editedProduct.imageUrl);

  var isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      final String pId = ModalRoute.of(context).settings.arguments;
      if (pId != null) {
        _editedProduct = Provider.of<Products>(context)
            .items
            .firstWhere((element) => element.id == pId);
        print(pId);
        print(_editedProduct.id);

        _imageController.text = _editedProduct.imageUrl;
      }

      //print(_imageController.text);

      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveinfo)
        ],
        title: Text('Edit item'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _golbalkey,
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: _editedProduct.title,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'please enter a title ';
                      }
                      return null;
                    },

                    onSaved: (value) {
                      _editedProduct = Product(
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                          title: value,
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          price: _editedProduct.price);
                    },
                    decoration: InputDecoration(labelText: 'title'),
                    textInputAction: TextInputAction.next,
                    //focusNode: _titlefocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusprice);
                    },
                  ),
                  TextFormField(
                      initialValue: _editedProduct.price.toString(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter a price ';
                        }
                        if (double.tryParse(value) == null) {
                          return ' please enter valid value';
                        }
                        if (double.tryParse(value) <= 0) {
                          return 'please enter positive value';
                        }

                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      focusNode: _focusprice,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            isFavorite: _editedProduct.isFavorite,
                            imageUrl: _editedProduct.imageUrl,
                            price: double.parse(value),
                            id: _editedProduct.id);
                      }),
                  TextFormField(
                      initialValue: _editedProduct.description,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'please enter some details ';
                        }
                        if (value.length < 10) {
                          return 'Not enough info!!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.next,
                      maxLines: 3,
                      onSaved: (value) {
                        _editedProduct = Product(
                            title: _editedProduct.title,
                            description: value,
                            imageUrl: _editedProduct.imageUrl,
                            isFavorite: _editedProduct.isFavorite,
                            price: _editedProduct.price,
                            id: _editedProduct.id);
                      }),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        margin: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.01),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: _imageController.text.isEmpty
                            ? Text(
                                'enter your url image',
                                overflow: TextOverflow.fade,
                              )
                            : Image.network(
                                _imageController.text,
                                fit: BoxFit.cover,
                              ),
                        //: Image.asset('${_imageController.text}'),
                      ),
                      Expanded(
                        child: TextFormField(
                          //initialValue: _editedProduct.imageUrl, we cant add initial value here cause of we have controller
                          //so we add initial value to the controller in change dependancy
                          validator: (value) {
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter valid URL';
                            }
                            // if (!value.endsWith('png') &&
                            //     !value.endsWith('jpg') &&
                            //     !value.endsWith('jpeg')) {
                            //   return 'please enter valid URL';
                            // }

                            return null;
                          },
                          controller: _imageController,
                          focusNode: _focusImage,
                          decoration: InputDecoration(labelText: 'Image url'),
                          textInputAction: TextInputAction.done,
                          onSaved: (value) {
                            _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                isFavorite: _editedProduct.isFavorite,
                                description: _editedProduct.description,
                                imageUrl: value,
                                price: _editedProduct.price);
                          },
                          onFieldSubmitted: (_) {
                            _saveinfo();
                          },
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
    );
  }
}
