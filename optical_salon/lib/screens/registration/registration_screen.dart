import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/screens/login/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static String tag = 'registration-screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

    final name = TextFormField(
      keyboardType: TextInputType.name,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final phone = TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '+375 (XX) XXX-XX-XX',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text("Sign Up"),
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF00A693),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
    );

    final signInButton = Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      // ignore: deprecated_member_use
      child: OutlinedButton(
        child: Text(
          'Sign In',
          style: TextStyle(color: Color(0xFF00A693)),
        ),
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: Color(0xFF00A693),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
        ),
      ),
    );

    final formLabel = Text(
      'Registration',
      style: TextStyle(
        color: Colors.black54,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
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
            name,
            SizedBox(height: 8.0),
            phone,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            signUpButton,
            signInButton
          ],
        ),
      ),
    );
  }
}
