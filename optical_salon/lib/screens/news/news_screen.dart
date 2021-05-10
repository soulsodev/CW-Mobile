import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';
import 'package:optical_salon/screens/news/read_news_screen.dart';

import 'components/primary_card.dart';
import 'components/secondary_card.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 15.0),
              child: Text(
                'LATEST NEWS',
                style: kTitleCard,
              ),
            ),
            Container(
              width: double.infinity,
              height: 300.0,
              padding: EdgeInsets.only(left: 18.0),
              child: ListView.builder(
                itemCount: newsList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var news = newsList[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadNewsScreen(news: news),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 12.0),
                      child: PrimaryCard(news: news),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 25.0),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  'BASED ON YOUR READING HISTORY',
                  style: kNonActiveTabStyle,
                ),
              ),
            ),
            ListView.builder(
                itemCount: recentList.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  var recent = recentList[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadNewsScreen(news: recent),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 135.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                      child: SecondaryCard(news: recent),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
