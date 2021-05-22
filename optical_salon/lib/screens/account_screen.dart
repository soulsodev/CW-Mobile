import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:optical_salon/models/consultation.dart';
import 'package:optical_salon/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'authentification/login_screen.dart';
import 'package:http/http.dart' as http;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  SharedPreferences sharedPreferences;
  List<Consultation> consultationsList = [];
  User user;

  @override
  initState() {
    super.initState();
  }

  logOut() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    // ignore: deprecated_member_use
    sharedPreferences.commit();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  getUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString('access_token');
    final _url = '$url/users/profile';
    var _uri = Uri.parse(_url);
    var res = await http.get(
      _uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    var jsonResponse = jsonDecode(res.body);

    var userTemp = User.profile(jsonResponse['id'], jsonResponse['name'],
        jsonResponse['phone'], jsonResponse['email'], []);

    user = userTemp;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    final userInfoLabel = Center(
      child: Text(
        'User information',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );

    final name = Row(
      children: [
        Text(
          'Name:',
          style: TextStyle(
            color: Color(0xFF00A693),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        SizedBox(width: 5.0),
        Text(
          user.name,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );

    final email = Row(
      children: [
        Text(
          'Email:',
          style: TextStyle(
            color: Color(0xFF00A693),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        SizedBox(width: 5.0),
        Text(
          user.email,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );

    final phone = Row(
      children: [
        Text(
          'Phone:',
          style: TextStyle(
            color: Color(0xFF00A693),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        SizedBox(width: 5.0),
        Text(
          user.phone,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );

    // final service = Row(
    //   children: [
    //     Text(
    //       'Phone:',
    //       style: TextStyle(
    //         color: Color(0xFF00A693),
    //         fontWeight: FontWeight.bold,
    //         fontSize: 20.0,
    //       ),
    //     ),
    //     SizedBox(width: 5.0),
    //     Text(
    //       user.userConsultations[0].service,
    //       style: TextStyle(fontSize: 20.0),
    //     ),
    //   ],
    // );

    final userConsultationsLabel = Center(
      child: Text(
        'User consultations',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A693),
        title: Text('Account'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () => logOut(),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          SizedBox(height: 16.0),
          userInfoLabel,
          SizedBox(height: 16.0),
          name,
          SizedBox(height: 8.0),
          email,
          SizedBox(height: 8.0),
          phone,
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
