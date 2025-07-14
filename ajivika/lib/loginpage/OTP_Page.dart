import 'package:ajivika/loginpage/AuthenticationPage.dart';
import 'package:ajivika/loginpage/Phone_Number_page.dart';
import 'package:ajivika/loginpage/loginpage_provider.dart';
import 'package:ajivika/main.dart';
import 'package:ajivika/workersection/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../languagepage/language_page.dart';
import 'choosing_page.dart';

class OTP_Page extends StatefulWidget {
  String PhoneNumber;
  OTP_Page({required this.PhoneNumber});

  @override
  State<OTP_Page> createState() => _OTP_PageState();
}

class _OTP_PageState extends State<OTP_Page> {
  TextEditingController otpController = TextEditingController();
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
                "Please enter OTP".tr,
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
              child: Row(
                children: [
                  Text(
                    "sent at +91 ".tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "${widget.PhoneNumber}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.edit, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),

          Container(color: Colors.white, height: 10),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              child: PinCodeTextField(
                appContext: context, // ✅ REQUIRED
                autoFocus: true,
                length: 6,
                controller: otpController,
                keyboardType: TextInputType.number,
                autoDismissKeyboard: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 45,
                  activeColor: Color(0xff2667FF),
                  selectedColor: Colors.green,
                  inactiveColor: Color(0xff2667FF),
                ),
                onCompleted: (OTP) async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.white,
                          rightDotColor: Color(0xff2667FF),
                          size: 50,
                        ),
                      );
                    },
                  );
                  print(OTP);
                  bool check = await AuthenticationbyOTP.VerifyOTP(
                    PhoneNumber: widget.PhoneNumber,
                    OTP: OTP,
                  );
                  if (check) {
                    context.read<PhoneNoProvider>().finalisenumber();
                    context.read<PhoneNoProvider>().CheckProfile(context);
                  } else {
                    otpController.clear();
                    Navigator.of(context, rootNavigator: true).pop();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Incorrect OTP".tr)));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
