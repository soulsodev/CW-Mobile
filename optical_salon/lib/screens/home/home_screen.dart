import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';
import 'package:optical_salon/screens/home/read_news_screen.dart';

import 'components/primary_card.dart';
import 'components/secondary_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: bottomNavigationBar(),
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

  Container bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(top: BorderSide(color: Color(0xFF00A693), width: 1.0))),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF00A693),
        unselectedItemColor: Colors.black54,
        elevation: 1.0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: Color(0xFF00A693),
              width: 24.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color: Color(0xFF00A693),
              width: 24.0,
            ),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bag.svg',
              color: Color(0xFF00A693),
              width: 24.0,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/clipboard.svg',
              color: Color(0xFF00A693),
              width: 24.0,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              color: Color(0xFF00A693),
              width: 24.0,
            ),
            label: 'Profile',
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFF00A693),
      elevation: 0.0,
      actions: [],
    );
  }
}
