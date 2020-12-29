import 'dart:convert';
import 'package:suria_shop_online/constantsvar.dart';
import '../modules/httpexception.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _productList = [
    //   Product(
    //     id: 'p11',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //       id: 'p2',
    //       title: 'Trousers',
    //       description: 'A nice pair of trousers.',
    //       price: 59.99,
    //       imageUrl:
    //           'https://www.google.com/maps/uv?pb=!1s0x31cc48250ed98461%3A0x9564e357f5aae8b5!3m1!7e115!4shttps%3A%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipPIhLSTeV2ryrQuoX_-VvcPgpfuqpKVkB7rx2lH%3Dw160-h160-k-no!5ssuria%20wholesaler%20-%20Google%20Search!15sCgIgAQ&imagekey=!1e10!2sAF1QipNclllNk670z9lfQG-pFfgw2UccQupp8eQPiDU&hl=en&sa=X&ved=2ahUKEwjSgsKC-ObtAhVozzgGHXswAxAQoiowFnoECCQQAw')
    //
  ];

  Product fineProdbyID(String id) {
    return _productList.firstWhere((element) => element.id == id);
  }

  List<Product> get items {
    return [..._productList];
  }

  Future<void> fetchandsetitems() async {
    const url =
        'https://suria-shoponline-default-rtdb.firebaseio.com/products.json';
    final List<Product> _loadedProducts = [];

    try {
      final response = await http.get(url);
      final extactedData = json.decode(response.body) as Map<String, dynamic>;
      extactedData.forEach((pID, value) {
        _loadedProducts.add(Product(
            id: pID,
            isFavorite: value[isFavoriteP],
            title: value[titleP],
            price: value[priceP],
            description: value[descriptionP],
            imageUrl: value[imageUrlP]));
      });
      print(_loadedProducts);
      _productList = _loadedProducts;
    } catch (err) {
      throw err;
    }
  }

  List<Product> get favItems {
    return items.where((element) => element.isFavorite).toList();
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://suria-shoponline-default-rtdb.firebaseio.com/products/$id.jsn';
    var index = _productList.indexWhere((element) => element.id == id);
    Product productexist = _productList[index];
    _productList.removeAt(index);
    notifyListeners();
    final respones = await http.delete(url);
    //_productList.removeWhere((element) => element.id == id);

    if (respones.statusCode >= 400) {
      _productList.insert(index, productexist);
      notifyListeners();
      throw new HttpException('went wrong!!');
      // throw HttpException('something went wrong!');
    }

    //print(respones.statusCode);
  }

  Future<void> addProduct(Product newProduct) async {
    const url =
        'https://suria-shoponline-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(url,
          body: json.encode({
            'price': newProduct.price,
            //'id': DateTime.now().toString(),
            'imageUrl': newProduct.imageUrl,
            'description': newProduct.description,
            'title': newProduct.title,
            'isFavorite': newProduct.isFavorite,
          }));
      final productUpdated = Product(
          id: json.decode(response.body)['name'],
          price: newProduct.price,
          title: newProduct.title,
          description: newProduct.description,
          imageUrl: newProduct.imageUrl,
          isFavorite: newProduct.isFavorite);
      _productList.insert(0, productUpdated);
      notifyListeners();
      print(productUpdated.id);
    } catch (err) {
      throw err;
    }

    //
  }

  Future<void> updateItem(String id, Product newProduct) async {
    final url =
        'https://suria-shoponline-default-rtdb.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(url,
          body: json.encode({
            priceP: newProduct.price,
            imageUrlP: newProduct.imageUrl,
            descriptionP: newProduct.description,
            titleP: newProduct.title,
          }));
      // if (response.statusCode >= 400) {
      //   return;
      // }
    } catch (error) {
      throw error;
    }

    Product productUpdated = newProduct;
    // Product(
    // price: newProduct.price,
    // id: id,
    // imageUrl: newProduct.imageUrl,
    // description: newProduct.description,
    // title: newProduct.title,
    // isFavorite: newProduct.isFavorite);
    var index = items.indexWhere((element) => element.id == id);
    _productList[index] = productUpdated;
    notifyListeners();
  }
}
