import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/user.dart';
import 'package:optical_salon/screens/home_screen.dart';
import 'package:optical_salon/screens/authentification/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static String tag = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  signIn(String email, String password) async {
    final _url = '$url/auth/login';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {'username': email, 'password': password};
    var jsonResponse;

    var res = await http.post(Uri.parse(_url), body: body);
    print(res.statusCode);
    // Check API status
    if (res.statusCode == 201 || res.statusCode == 200) {
      jsonResponse = json.decode(res.body);

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
          sharedPreferences.setString(
              'access_token', jsonResponse['access_token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => false);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset(
          'assets/images/logo.png',
          color: Color(0xFF00A693),
        ),
      ),
    );

    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final signInButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text("Sign In"),
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signIn(_emailController.text, _passwordController.text);
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

    final signUpButton = OutlinedButton(
      child: Text(
        'Sign Up',
        style: TextStyle(
          color: Color(0xFF00A693),
        ),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegistrationScreen(),
        ),
      ),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          width: 1.0,
          color: Color(0xFF00A693),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      onPressed: () {},
    );

    final formLabel = Text(
      'Login',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
                  logo,
                  SizedBox(height: 48.0),
                  Align(
                    alignment: Alignment.center,
                    child: formLabel,
                  ),
                  SizedBox(height: 16.0),
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 8.0),
                  signInButton,
                  signUpButton,
                  forgotLabel
                ],
              ),
      ),
    );
  }
}
