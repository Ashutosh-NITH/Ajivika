import 'package:ajivika/loginpage/AuthenticationPage.dart';
import 'package:ajivika/loginpage/OTP_Page.dart';
import 'package:ajivika/loginpage/choosing_page.dart';
import 'package:ajivika/loginpage/loginpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../languagepage/language_page.dart';

class Phone_Number_Page extends StatelessWidget {
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
                "your phone number".tr,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          ),

          Container(color: Colors.white, height: 10),

          Consumer<PhoneNoProvider>(
            builder: (ctx, provider, __) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    onChanged: (value) {
                      provider.setno(value);
                    },
                    decoration: InputDecoration(
                      label: Text("Phone Number".tr),
                      hintText: "Phone Number".tr,
                      prefixText: "+91    ",
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
              );
            },
          ),
          //submit button
          Consumer<PhoneNoProvider>(
            builder: (ctx, provider, __) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    provider.onloading();
                    var number = provider.number.toString().trim();
                    if (number.length == 10) {
                      String E16Formatnumber = "+91$number";
                      print(E16Formatnumber);
                      bool sent = await AuthenticationbyOTP.sendOtp(
                        PhoneNumber: E16Formatnumber,
                      );
                      if (sent) {
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) =>
                                OTP_Page(PhoneNumber: E16Formatnumber),
                          ),
                        );
                        provider.offlaoding();
                      } else {
                        provider.offlaoding();
                        print("error");
                        ScaffoldMessenger.of(ctx).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Unable to send message on this number".tr,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }
                    } else {
                      provider.offlaoding();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please enter your phone number".tr,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.sendotploading
                        ? Color(0xff87BFFF)
                        : provider.checkno()
                        ? Color(0xff2667FF)
                        : Color(0xff87BFFF),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ctx.watch<PhoneNoProvider>().sendotploading
                            ? LoadingAnimationWidget.flickr(
                                size: 20,
                                leftDotColor: Colors.white,
                                rightDotColor: Colors.white,
                              )
                            : Text(
                                "Next".tr,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
