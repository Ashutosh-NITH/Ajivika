import 'package:ajivika/Profilepage/ProfilePageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../languagepage/language_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (ctx, provider, __) {
        provider.initiliseinfo();
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                margin: EdgeInsets.only(top: 30.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                  minRadius: 60,
                  maxRadius: 60,
                ),
              ),
              Text(
                "Upload Photo",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff2667FF),
                ),
              ),
              SizedBox(height: 15),
              Text(
                provider.name,
                style: TextStyle(fontFamily: "Poppins", fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                provider.profession,
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),

              // main body
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your name".tr,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.name,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your phone number".tr,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.phone,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.edit),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your Profession".tr,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.profession,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "request change",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Text(
                "Log Out",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
