import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:optical_salon/screens/home/home_screen.dart';
import 'package:optical_salon/screens/registration/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    final signInButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text("Sign In"),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF00A693),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
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
          borderRadius: BorderRadius.circular(24.0),
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
