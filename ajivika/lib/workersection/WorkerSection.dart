import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../languagepage/language_page.dart';

class JobAppliedHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(color: Colors.white, height: 50),
          //top appbar
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // left part => help
                InkWell(
                  onTap: () {
                    // perform action => get help => customer care
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      FaIcon(
                        FontAwesomeIcons.headset,
                        color: Color(0xff2667FF),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "help".tr,
                        style: TextStyle(color: Color(0xff2667FF)),
                      ),
                    ],
                  ),
                ),
                // right part => voice and language
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // perform action => speak on tap of audio icon
                      },
                      child: FaIcon(
                        FontAwesomeIcons.volumeHigh,
                        color: Color(0xff2667FF),
                      ),
                    ),
                    SizedBox(width: 25),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) => language_page(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "language".tr,
                            style: TextStyle(color: Color(0xff2667FF)),
                          ),
                          SizedBox(width: 5),
                          FaIcon(
                            FontAwesomeIcons.angleDown,
                            color: Color(0xff2667FF),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
          Container(color: Colors.white, height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Job Applied History".tr,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
