import 'dart:async';

import 'package:ajivika/loginpage/Phone_Number_page.dart';
import 'package:ajivika/loginpage/choosing_page.dart';
import 'package:ajivika/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class splash_screen extends StatefulWidget{
  @override

  State<splash_screen> createState() => _splash_screenState();

}

class _splash_screenState extends State<splash_screen> {
@override
  void initState() {
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement((context), MaterialPageRoute(builder: (context)=>Phone_Number_Page()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: Color(0xff1076e5),
          color: Color(0xff2667FF),
          child: Center(child: Image.asset("assets/images/logo.png", width: 250,)),
        ),
      ),
    );
  }
}