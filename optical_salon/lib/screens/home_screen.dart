import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optical_salon/screens/account_screen.dart';
import 'package:optical_salon/screens/booking_screen.dart';
import 'package:optical_salon/screens/cart_screen.dart';
import 'package:optical_salon/screens/catalog/catalog_screen.dart';
import 'package:optical_salon/screens/authentification/login_screen.dart';
import 'package:optical_salon/screens/news/news_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences sharedPreferences;
  int _currentIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    NewsScreen(),
    CatalogScreen(),
    CartScreen(),
    BookingScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('access_token') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(context),
      bottomNavigationBar: bottomNavigationBar(),
      body: _widgetOptions.elementAt(_currentIndex),
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
        onTap: _onItemTapped,
      ),
    );
  }
}
