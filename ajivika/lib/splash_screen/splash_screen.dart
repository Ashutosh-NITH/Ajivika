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
    var checklogging = pref.getBool(MyApp.ISLOGGEDKEY);
    var checkverified = pref.getBool(MyApp.ISVERIFIEDKEY);
    var checkprofession = pref.getString(MyApp.USER_PROFESSION_KEY);
    if (checkverified != null) {
      if (checkverified) {
        if (checklogging != null) {
          if (checklogging) {
            if (checkprofession == 'Worker') {
              Navigator.push(
                (context),
                MaterialPageRoute(builder: (context) => worker_bottom_navbar()),
              );
            } else {
              Navigator.push(
                (context),
                MaterialPageRoute(
                  builder: (context) => contractor_bottom_navbar(),
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
