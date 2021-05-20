import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import 'components/title_with_image.dart';
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
            TitleWithImage(product: product),
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
