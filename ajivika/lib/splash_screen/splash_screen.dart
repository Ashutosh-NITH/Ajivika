import 'dart:async';
import 'package:ajivika/contractorsection/bottom_navbar/contractor_navbar.dart';
import 'package:ajivika/loginpage/Phone_Number_page.dart';
import 'package:ajivika/loginpage/choosing_page.dart';
import 'package:ajivika/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../workersection/bottom_navbar/bottom_navbar.dart';

class splash_screen extends StatefulWidget {
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      wheretogo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: Color(0xff1076e5),
          color: Color(0xff2667FF),
          child: Center(
            child: Image.asset("assets/images/logo.png", width: 250),
          ),
        ),
      ),
    );
  }

  Future<void> wheretogo() async {
    final pref = await SharedPreferences.getInstance();
    final checklogging = pref.getBool(MyApp.ISLOGGEDKEY);
    final checkverified = pref.getBool(MyApp.ISVERIFIEDKEY);
    final checkprofession = pref.getString(MyApp.USER_PROFESSION_KEY);
    final city = await pref.getString(MyApp.USER_CITY);
    final lat = await pref.getDouble(MyApp.USER_LATITUDE);
    final long = await pref.getDouble(MyApp.USER_LONGITUDE);
    if (checkverified != null) {
      if (checkverified) {
        if (checklogging != null) {
          if (checklogging) {
            if (checkprofession == 'Worker') {
              Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) =>
                      worker_bottom_navbar(currlat: lat!, currlong: long!),
                ),
              );
            } else {
              Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) =>
                      contractor_bottom_navbar(currlat: lat!, currlong: long!),
                ),
              );
            }
          } else {
            Navigator.push(
              (context),
              MaterialPageRoute(builder: (context) => choosing_page()),
            );
          }
        } else {
          Navigator.push(
            (context),
            MaterialPageRoute(builder: (context) => choosing_page()),
          );
        }
      } else {
        Navigator.push(
          (context),
          MaterialPageRoute(builder: (context) => Phone_Number_Page()),
        );
      }
    } else {
      Navigator.push(
        (context),
        MaterialPageRoute(builder: (context) => Phone_Number_Page()),
      );
    }
  }
}
