import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/models/consultation.dart';
import 'package:http/http.dart' as http;
import 'package:optical_salon/models/salon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _serviceController = TextEditingController();
  String dropdownValue;
  List<Salon> salonsList = [];
  Salon _selectedSalon;
  var dio = Dio();
  DateTime _dateTime;
  DateFormat dateFormat;

  @override
  initState() {
    super.initState();
    getSalons();
    _selectedSalon = Salon(100, 'Optical salon', 'Minsk', 'Belorusskaya, 21');
    print(salonsList.length);
  }

  Future<Consultation> addConsultation(
      int salonId, String datetime, String service) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString('access_token');
    final _url = '$url/consultations';
    Map<String, dynamic> req = {
      'service': service,
      'salonId': salonId,
      'datetime': datetime,
    };
    dio.options.headers['authorization'] = 'Bearer $accessToken';
    dio.options.headers['Content-Type'] = 'application/json';
    var res = await dio.post(_url, data: jsonEncode(req));

    if (res.statusCode == 200 || res.statusCode == 201) {
      print('Added new consultation!');
    } else {
      throw Exception('Failed to add consultation');
    }
  }

  getSalons() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String accessToken = sharedPreferences.getString('access_token');
    final _url = '$url/salons';
    var _uri = Uri.parse(_url);
    var res = await http.get(
      _uri,
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    var jsonResponse = jsonDecode(res.body);

    List<Salon> salonsListTemp = [];
    salonsList.clear();

    for (var s in jsonResponse) {
      Salon salon = Salon(s['id'], s['name'], s['city'], s['address']);
      salonsListTemp.add(salon);
    }
    setState(() {
      salonsList = salonsListTemp;
      _selectedSalon = salonsList[0];
    });
    return salonsList;
  }

  @override
  Widget build(BuildContext context) {
    final selectSalonLabel = Center(
      child: Text(
        'Select optical salon',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );

    List<DropdownMenuItem> items = salonsList.map((item) {
      return DropdownMenuItem<Salon>(
        child: Text(item.name),
        value: item,
      );
    }).toList();

    if (items.isEmpty) {
      items = [
        DropdownMenuItem(
          child: Text(_selectedSalon.name),
          value: _selectedSalon,
        )
      ];
    }

    final salon = DropdownButton(
      items: items,
      onChanged: (newVal) => setState(() => _selectedSalon = newVal),
      value: _selectedSalon,
    );

    final selectDateLabel = Center(
      child: Text(
        'Select consultation date',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );

    final datetimePicker = SizedBox(
      height: 300.0,
      child: CupertinoDatePicker(
        initialDateTime: _dateTime,
        minimumDate: DateTime.now(),
        use24hFormat: true,
        onDateTimeChanged: (dateTime) {
          setState(() {
            _dateTime = dateTime;
            print(_dateTime);
          });
        },
      ),
    );

    final selectService = Center(
      child: Text(
        'Select service',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );

    final service = TextFormField(
      controller: _serviceController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Service field could not be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Service',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );

    final addConsultationButton = Padding(
      padding: EdgeInsets.only(top: 16.0),
      // ignore: deprecated_member_use
      child: ElevatedButton(
        child: Text('Book'),
        onPressed: () {
          _key.currentState.validate();
          DateTime dateTimeNow = DateTime.now();
          if (!dateTimeNow.isBefore(_dateTime)) {
            print('Date choosen before now');
            return;
          }
          addConsultation(
            _selectedSalon.id,
            _dateTime.toString(),
            _serviceController.text,
          );
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00A693),
        title: Text('Booking'),
        centerTitle: true,
      ),
      body: Container(
        child: Form(
          key: _key,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 16.0),
              selectSalonLabel,
              salon,
              SizedBox(height: 16.0),
              selectDateLabel,
              datetimePicker,
              SizedBox(height: 16.0),
              selectService,
              SizedBox(height: 16.0),
              service,
              SizedBox(height: 8.0),
              addConsultationButton,
            ],
          ),
        ),
      ),
    );
  }
}
