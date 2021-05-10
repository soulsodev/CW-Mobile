import 'package:flutter/material.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';

class ReadNewsScreen extends StatelessWidget {
  final News news;

  const ReadNewsScreen({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF00A693),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
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
                    image: NetworkImage(news.image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 15.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFF00A693), width: 1.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 5.0,
                        backgroundColor: Color(0xFF00A693),
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        news.category,
                        style: kCategoryTitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Text(
              news.title,
              style: kTitleCard.copyWith(fontSize: 28.0),
            ),
            SizedBox(height: 15.0),
            Row(
              children: [
                Text(
                  news.date,
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
