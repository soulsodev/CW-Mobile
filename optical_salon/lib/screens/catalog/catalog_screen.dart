import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:optical_salon/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'add_product_screen.dart';
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
    getAllProducts(null, null);
  }

  getAllProducts(String name, String price) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString('access_token');
    var _url = '$url/products?';
    if (name != null && name != '') {
      _url += 'name=$name&';
    }
    if (price != null && price != '') {
      _url += 'price=$price';
    }
    print(_url);
    var _uri = Uri.parse(_url);
    var res = await http.get(
      _uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    print(res);
    var jsonResponse = await jsonDecode(res.body);
    print(jsonResponse);
    List<Product> productsListTemp = [];
    productsList.clear();

    for (var p in jsonResponse) {
      Product news = Product(
          p['id'],
          p['name'],
          p['brand'],
          p['model'],
          p['description'],
          p['cost'],
          p['country'],
          p['material'],
          p['photo'],
          p['isFavorite']);
      productsListTemp.add(news);
    }
    setState(() {
      productsList = productsListTemp;
    });
    return productsList;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _costController = TextEditingController();

    final name = Container(
      width: 200.0,
      child: TextFormField(
        controller: _nameController,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Title',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );

    final cost = Container(
      width: 200.0,
      child: TextFormField(
        controller: _costController,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'Max cost',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );

    final searchByName = Container(
      width: 100.0,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        // ignore: deprecated_member_use
        child: ElevatedButton(
          child: Text('Search'),
          onPressed: () {
            //function
            getAllProducts(_nameController.text, null);
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF00A693),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ),
    );

    final filterByCostButton = Container(
      width: 100.0,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        // ignore: deprecated_member_use
        child: ElevatedButton(
          child: Text('Filter'),
          onPressed: () {
            //function
            getAllProducts(null, _costController.text);
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF00A693),
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A693),
        title: Text('Catalog'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFA500),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (BuildContext context) => AddProductScreen()),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    name,
                    searchByName,
                  ],
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cost,
                    filterByCostButton,
                  ],
                ),
              ],
            ),
          ),
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
