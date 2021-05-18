import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';
import 'package:optical_salon/screens/news/update_news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadNewsScreen extends StatefulWidget {
  final News news;

  const ReadNewsScreen({Key key, this.news}) : super(key: key);

  @override
  _ReadNewsScreenState createState() => _ReadNewsScreenState(news);
}

class _ReadNewsScreenState extends State<ReadNewsScreen> {
  final News news;

  _ReadNewsScreenState(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF00A693),
        title: Text('Read news'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
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
                builder: (context) => UpdateNewsScreen(news: news),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => deleteNewsAlert(news.id),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: ListView(
          children: [
            SizedBox(height: 12.0),
            Hero(
              tag: news.image,
              child: Container(
                height: 220.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image:
                        NetworkImage('http://192.168.0.103:5000/' + news.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              news.title,
              style: kTitleCard.copyWith(fontSize: 28.0),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Text(
                  DateFormat("yyyy-MM-dd").parse(news.date).day.toString() +
                      '.' +
                      DateFormat("yyyy-MM-dd")
                          .parse(news.date)
                          .month
                          .toString() +
                      '.' +
                      DateFormat("yyyy-MM-dd").parse(news.date).year.toString(),
                  style: kDetailContent,
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Text(
              news.description,
              style: descriptionStyle,
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }

  Future<News> deleteNews(int id) async {
    var dio = Dio();
    var sharedPreferences = await SharedPreferences.getInstance();
    String access_token = sharedPreferences.getString('access_token');
    final _url = "http://192.168.0.103:5000/news/$id";
    //final _url = "http://192.168.43.244:5000/news/$id";
    //final _url = "http: //localhost:5000/news/$id";
    //final _url = "http://10.0.2.2:5000/news/$id";

    dio.options.headers["authorization"] = "Bearer $access_token";
    var res = await dio.deleteUri(
      Uri.parse(_url),
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      print('Deleted!');
      Navigator.pop(context);
    } else {
      throw Exception('Failed to delete news');
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
          deleteNews(id);
          Navigator.of(context).pop();
        },
      ),
    );

    var alert = AlertDialog(
      title: const Text('Are you sure?'),
      content: Text('Would you like to delete selected news?'),
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
