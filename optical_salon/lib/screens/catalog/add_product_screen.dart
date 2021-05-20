import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optical_salon/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _materialController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _costController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  File _image;
  Dio dio = Dio();

  // ignore: missing_return
  Future<Product> uploadProduct(
      String name,
      String brand,
      String model,
      String description,
      String cost,
      String material,
      String country,
      File image) async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString('access_token');

    final _url = '$url/products';

    var formData = FormData.fromMap({
      'name': name,
      'brand': brand,
      'model': model,
      'description': description,
      'cost': cost,
      'material': material,
      'country': country,
      'photo': await MultipartFile.fromFile(_image.path, filename: _image.path),
    });
    dio.options.headers["authorization"] = "Bearer $accessToken";
    var res = await dio.post(_url, data: formData);

    if (res.statusCode == 200 || res.statusCode == 201) {
      print('Uploaded!');
    } else {
      throw Exception('Failed to upload news');
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final name = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Name field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final brand = TextFormField(
      controller: _brandController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Brand field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Brand',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final model = TextFormField(
      controller: _modelController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Model field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Model',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final description = TextFormField(
      controller: _descriptionController,
      maxLines: 5,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Description field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Description',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final material = TextFormField(
      controller: _materialController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Material field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Material',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final country = TextFormField(
      controller: _countryController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Model field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Country',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final cost = TextFormField(
      controller: _costController,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Cost field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Cost',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final uploadProductButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text('Upload'),
        onPressed: () {
          _key.currentState.validate();
          setState(() {
            uploadProduct(
                _nameController.text,
                _brandController.text,
                _modelController.text,
                _descriptionController.text,
                _costController.text,
                _materialController.text,
                _countryController.text,
                _image);
            Navigator.pop(context);
          });
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF00A693),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );

    final imagePicker = Center(
      child: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: Container(
          height: 200.0,
          width: 400.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF00A693),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.file(
                    _image,
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  width: 200,
                  height: 400,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A693),
        title: Text(
          'Adding product',
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 16.0),
              imagePicker,
              SizedBox(height: 16.0),
              name,
              SizedBox(height: 16.0),
              brand,
              SizedBox(height: 16.0),
              model,
              SizedBox(height: 16.0),
              description,
              SizedBox(height: 16.0),
              material,
              SizedBox(height: 16.0),
              country,
              SizedBox(height: 8.0),
              cost,
              SizedBox(height: 8.0),
              uploadProductButton,
            ],
          ),
        ),
      ),
    );
  }
}
