import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../languagepage/language_page.dart';
import 'loginpage_provider.dart';

class EnterNamePage extends StatelessWidget {
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

          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Please enter".tr,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),

          Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "your name".tr,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),

          Container(color: Colors.white, height: 10),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: TextField(
                keyboardType: TextInputType.text,
                onChanged: (input) {
                  context.read<NamePageProvider>().setname(input);
                },
                // controller: context.read<NamePageProvider>().namecontroller,
                decoration: InputDecoration(
                  label: Text("Full Name".tr),
                  hintText: "Full Name".tr,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xff2667FF)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xff2667FF)),
                  ),
                ),
              ),
            ),
          ),
          //submit button
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () async {
                if (context.read<NamePageProvider>().checkstring()) {
                  context.read<NamePageProvider>().finalisename();
                  context.read<NamePageProvider>().SaveProfile(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please Enter Your Name".tr)),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.watch<NamePageProvider>().checkstring()
                    ? Color(0xff2667FF)
                    : Color(0xff87BFFF),
              ),
              child: Text(
                "Confirm".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
