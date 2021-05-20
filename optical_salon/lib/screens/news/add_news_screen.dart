import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';


class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key key}) : super(key: key);

  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  File _image;
  Dio dio = Dio();
  FormData formData = FormData();

  // ignore: missing_return
  Future<News> uploadNews(
      String title, String description, File image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString('access_token');

    final _url = '$url/news';

    var formData = FormData.fromMap({
      'title': title,
      'description': description,
      'image': await MultipartFile.fromFile(_image.path, filename: _image.path),
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
    final title = TextFormField(
      controller: _titleController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Title field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Title',
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

    final uploadNewsButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text('Upload'),
        onPressed: () {
          _key.currentState.validate();
          setState(() {
            uploadNews(
              _titleController.text,
              _descriptionController.text,
              _image,
            );
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
        backgroundColor: Colors.white,
        title: Text(
          'Adding news',
          style: TextStyle(
            color: Color(0xFF00A693),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF00A693),
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
              title,
              SizedBox(height: 16.0),
              description,
              SizedBox(height: 8.0),
              uploadNewsButton,
            ],
          ),
        ),
      ),
    );
  }
}
