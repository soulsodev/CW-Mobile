import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';
import 'package:optical_salon/screens/news/add_news_screen.dart';
import 'package:optical_salon/screens/news/read_news_screen.dart';
import 'package:http/http.dart' as http;

import 'components/primary_card.dart';
import 'components/secondary_card.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _currentIndex = 0;
  List<News> newsList = [];

  @override
  initState() {
    super.initState();
    getAllNews();
  }

  getAllNews() async {
    final _url = "http://192.168.0.103:5000/news";
    //final _url = "http://localhost:5000/news";
    //final _url = "http://10.0.2.2:5000/news";
    var _uri = Uri.parse(_url);
    var res = await http.get(_uri);
    var jsonResponse = jsonDecode(res.body);
    print(jsonResponse);

    List<News> newsListTemp = [];
    newsList.clear();

    for (var n in jsonResponse) {
      News news = News(n['title'], n['description'], n['image']);
      newsListTemp.add(news);
    }
    print('NEWS COUNT: ' + newsList.length.toString());
    setState(() {
      newsList = newsListTemp;
    });
    return newsList;
  }

  @override
  Widget build(BuildContext context) {
    if (newsList.isEmpty) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Loading..."),
          backgroundColor: Color(0xFFFFA500),
        ),
      );
    }
    else {
      return Scaffold(
        floatingActionButton: floatingActionButton(context),
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
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var news = newsList[index];
                    return InkWell(
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReadNewsScreen(news: news),
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
                  itemCount: newsList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    var recent = newsList[index];
                    return InkWell(
                      onTap: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReadNewsScreen(news: recent),
                            ),
                          ),
                      child: Container(
                        width: double.infinity,
                        height: 135.0,
                        margin:
                        EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8.0),
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

  FloatingActionButton floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(0xFFFFA500),
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () =>
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => AddNewsScreen()),
          ),
    );
  }
}
