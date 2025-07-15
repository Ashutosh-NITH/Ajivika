import 'package:ajivika/Profilepage/ProfilePageProvider.dart';
import 'package:ajivika/Profilepage/editprofile.dart';
import 'package:ajivika/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../languagepage/language_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfilePageProvider>().initiliseinfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilePageProvider>(
      builder: (ctx, provider, __) {
        return Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
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
                          callHelpline();
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
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: provider.imageurl.isNotEmpty
                            ? NetworkImage(provider.imageurl)
                            : AssetImage("assets/images/user.png"),
                        minRadius: 60,
                        maxRadius: 60,
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: CircleAvatar(
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: (context),
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      "Are  you sure you want to delete your profile image"
                                          .tr,
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () async {
                                          await provider.DeleteProfileImage()
                                              ? (ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "image deleted successfully",
                                                    ),
                                                  ),
                                                ))
                                              : (ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "error while deleting image ! TRY AGAIN !",
                                                    ),
                                                  ),
                                                ));

                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("No"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.delete_rounded,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                //upload photo
                GestureDetector(
                  onTap: () {
                    provider.UploadImage();
                  },
                  child: Text(
                    "Upload Photo",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2667FF),
                    ),
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
                      //naem
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

                              //edit name
                              GestureDetector(
                                onTap: () {
                                  showcustombottomsheet(context);
                                },
                                child: Icon(Icons.edit),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      //number
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),

                      //profession
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  callHelpline();
                                },
                                child: Text(
                                  "request change".tr,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //city
                      SizedBox(height: 10),
                      Text(
                        "Your City".tr,
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
                                provider.city,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  callHelpline();
                                },
                                child: Text(
                                  "request change".tr,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent,
                                  ),
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

                //logout
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: (context),
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            "Are you sure you want to log out ? It will remove your data from this device , but you can acccess it again using your phone number !"
                                .tr,
                          ),
                          actions: [
                            OutlinedButton(
                              onPressed: () {
                                provider.LogOut(context);
                              },
                              child: Text(
                                "Yes".tr,
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    "Log Out".tr,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
