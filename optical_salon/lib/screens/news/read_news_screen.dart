import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';
import 'package:optical_salon/screens/news/update_news_screen.dart';

class ReadNewsScreen extends StatelessWidget {
  final News news;

  const ReadNewsScreen({Key key, this.news}) : super(key: key);

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
                builder: (context) =>
                    UpdateNewsScreen(news: news),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: null,
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
                    image: NetworkImage('http://192.168.0.103:5000/' + news.image),
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
                  DateFormat("yyyy-MM-dd").parse(news.date).day.toString() + '.' +
                      DateFormat("yyyy-MM-dd").parse(news.date).month.toString() + '.' +
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
}
