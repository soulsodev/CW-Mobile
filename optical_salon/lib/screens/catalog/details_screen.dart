import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'components/update_product_screen.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key key, this.product}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState(product);
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Product product;
  bool _isFavoriteProduct = false;
  var dio = Dio();

  _DetailsScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Hero(
                          tag: "${product.id}",
                          child: Image.network(
                            '$url/' + product.photo,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name + ' ' + product.brand,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Color(0xFF00A693),
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: product.isFavorite == true
                              ? Icon(
                                  Icons.favorite,
                                  color: Color(0xFF00A693),
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Color(0xFF00A693),
                                ),
                          onPressed: () {
                            setState(() {
                              favoriteProduct(product.id);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "\$${product.cost}",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Color(0xFFFFA500),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Brand:',
                        style: TextStyle(
                          color: Color(0xFF00A693),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        product.brand,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Model:',
                        style: TextStyle(
                          color: Color(0xFF00A693),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        product.model,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Color(0xFF00A693),
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Material:',
                        style: TextStyle(
                          color: Color(0xFF00A693),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        product.material,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Text(
                        'Country:',
                        style: TextStyle(
                          color: Color(0xFF00A693),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        product.country,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.3),
              padding: EdgeInsets.only(
                top: size.height * 0.12,
                left: kDefaultPadding,
                right: kDefaultPadding,
              ),
              child: Column(
                children: <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void markAsFavorite() {
    setState(() => _isFavoriteProduct = !_isFavoriteProduct);
  }

  void favoriteProduct(int id) {
    setState(() {
      if (product.isFavorite != true) {
        addFavoriteProduct(id);
        product.isFavorite = true;
      } else {
        deleteFavoriteProduct(id);
        product.isFavorite = false;
      }
    });
  }

  Future<Product> addFavoriteProduct(int id) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString('access_token');
    final _url = '$url/users/favorite/products';
    Map<String, dynamic> req = {
      'productId': id,
    };
    dio.options.headers['authorization'] = 'Bearer $access_token';
    dio.options.headers['Content-Type'] = 'application/json';
    var res = await dio.post(_url, data: jsonEncode(req));

    if (res.statusCode == 200 || res.statusCode == 201) {
      print('Product added to favorite!');
    } else {
      throw Exception('Failed to add favorite product');
    }
  }

  Future<Product> deleteFavoriteProduct(int id) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString('access_token');
    final _url = '$url/users/favorite/products';
    Map<String, dynamic> req = {
      'productId': id,
    };
    dio.options.headers['authorization'] = 'Bearer $access_token';
    dio.options.headers['Content-Type'] = 'application/json';
    var res = await dio.deleteUri(Uri.parse(_url), data: jsonEncode(req));

    if (res.statusCode == 200 || res.statusCode == 201) {
      print('Product deleted from favorite!');
    } else {
      throw Exception('Failed to delete favorite product');
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Details'),
      centerTitle: true,
      backgroundColor: Color(0xFF00A693),
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateProductScreen(product: product),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          onPressed: () => deleteNewsAlert(product.id),
        ),
      ],
    );
  }

  Future<Product> deleteProduct(int id) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString('access_token');
    final _url = '$url/products/$id';

    dio.options.headers["authorization"] = "Bearer $access_token";
    var res = await dio.deleteUri(
      Uri.parse(_url),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      print('Deleted!');
      Navigator.pop(context);
    } else {
      throw Exception('Failed to delete product');
    }
  }

  void deleteNewsAlert(int id) async {
    Widget cancelButton = MaterialButton(
      child: Text('Cancel'),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget submitButton = MaterialButton(
      child: Text('Submit'),
      onPressed: () => setState(
        () {
          deleteProduct(id);
          Navigator.of(context).pop();
        },
      ),
    );

    var alert = AlertDialog(
      title: const Text('Are you sure?'),
      content: Text('Would you like to delete selected product?'),
      actions: [
        cancelButton,
        submitButton,
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }
}
