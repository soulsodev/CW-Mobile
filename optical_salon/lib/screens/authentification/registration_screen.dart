import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/models/user.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  static String tag = 'registration-screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<User> signUp(
      String name, String phone, String email, String password) async {
    final _url = "http://192.168.0.103:5000/auth/registration";
    //final _url = "http://localhost:5000/auth/registration";
    //final _url = "http://10.0.2.2:5000/auth/registration";
    Map<String, dynamic> req = {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password
    };
    final http.Response res = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req),
    );
    if (res.statusCode == 201) {
      return User.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to sign up user');
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

    final name = TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Name field is empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final phone = TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Phone field is empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: '+375 (XX) XXX-XX-XX',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Email field is empty';
        }
        return null;
      },
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
      validator: (val) {
        if (val.isEmpty) {
          return 'Password field is empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final confirmPassword = TextFormField(
      controller: _confirmPasswordController,
      autofocus: false,
      obscureText: true,
      validator: (val) {
        if (val.isEmpty) {
          return 'Password field is empty';
        } else if (val != _passwordController.text) {
          return 'Password mismatch';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final signUpButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text("Sign Up"),
        onPressed: () {
          setState(() {
            _key.currentState.validate();
            signUp(
              _nameController.text,
              _phoneController.text,
              _emailController.text,
              _passwordController.text,
            );
            Navigator.pop(context);
          });
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
            borderRadius: BorderRadius.circular(16.0),
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
      body: Form(
        key: _key,
        child: Center(
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
              confirmPassword,
              SizedBox(height: 8.0),
              signUpButton,
              signInButton
            ],
          ),
        ),
      ),
    );
  }
}
