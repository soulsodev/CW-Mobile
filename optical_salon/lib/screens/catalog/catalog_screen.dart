import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:optical_salon/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'components/item_card.dart';
import 'details_screen.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<Product> productsList = [];

  @override
  initState() {
    super.initState();
    getAllProducts();
  }

  getAllProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString('access_token');
    final _url = '$url/products';
    var _uri = Uri.parse(_url);
    var res = await http.get(
      _uri,
      headers: {'Authorization': 'Bearer $access_token'},
    );
    var jsonResponse = jsonDecode(res.body);

    List<Product> productsListTemp = [];
    productsList.clear();

    for (var p in jsonResponse) {
      Product news = Product(p['id'], p['name'], p['brand'], p['model'],
          p['description'], p['cost'], p['country'], p['material'], p['photo'], p['isFavorite']);
      productsListTemp.add(news);
    }
    setState(() {
      productsList = productsListTemp;
    });
    return productsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A693),
        title: Text('Catalog'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: GridView.builder(
                itemCount: productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding,
                  childAspectRatio: 0.73,
                ),
                itemBuilder: (context, index) => ItemCard(
                  product: productsList[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: productsList[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
