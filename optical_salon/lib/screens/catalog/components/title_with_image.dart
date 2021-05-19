import 'package:flutter/material.dart';
import 'package:optical_salon/models/product.dart';

import '../../../constants.dart';

class TitleWithImage extends StatelessWidget {
  const TitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          SizedBox(height: 16.0),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name + ' ' + product.brand,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Color(0xFF00A693), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    product.model,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Price\n",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A693),
                  ),
                ),
                TextSpan(
                  text: "\$${product.cost}",
                  style: Theme.of(context).textTheme.headline4.copyWith(
                      color: Color(0xFFFFA500),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
