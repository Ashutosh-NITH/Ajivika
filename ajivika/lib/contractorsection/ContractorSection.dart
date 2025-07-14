import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContractorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(color: Colors.white, height: 50),
          //heading
          Container(
            color: Colors.white,
            child: Text(
              "All your History".tr,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Container(color: Colors.white, height: 20),
        ],
      ),
    );
  }
}
