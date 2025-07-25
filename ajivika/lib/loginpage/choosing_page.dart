import 'package:ajivika/languagepage/language_page.dart';
import 'package:ajivika/loginpage/enter_name_page.dart';
import 'package:ajivika/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'loginpage_provider.dart';

class choosing_page extends StatelessWidget {
  final CONTRACTOR = "Contractor";
  final WORKER = "Worker";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ChoosingPageProvider>(
        builder: (ctx, provider, __) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //top app bar with icons
                Container(
                  margin: EdgeInsets.only(top: 45.0),
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
                              provider.emptyprofession();
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

                SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Tell us your profession".tr,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    "Please tell us what you do and we will help you find out relevant jobs or workers"
                        .tr,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),

                //body
                Expanded(
                  child: ListView(
                    children: [
                      select_profession_card(
                        ctx,
                        CONTRACTOR,
                        "I am a contractor and I need workers/labours".tr,
                      ),
                      select_profession_card(
                        ctx,
                        WORKER,
                        "I am a worker and I need job".tr,
                      ),
                    ],
                  ),
                ),

                // Next Button
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                    bottom: 20.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (provider.selected_profession.isNotEmpty) {
                        provider.finaliseprofession();
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) => EnterNamePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select your profession".tr),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: provider.selected_profession.isNotEmpty
                          ? Color(0xff2667FF)
                          : Color(0xff8ea9f9),
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Next".tr,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.arrowRight, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget select_profession_card(
    BuildContext context,
    String Profession,
    String subtitle,
  ) {
    return Container(
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color:
            context.watch<ChoosingPageProvider>().selected_profession ==
                Profession
            ? Color(0xffe9f6ff)
            : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color:
              context.watch<ChoosingPageProvider>().selected_profession ==
                  Profession
              ? Color(0xff2667FF)
              : Colors.grey,
        ),
      ),

      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListTile(
          title: Text(
            Profession,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          onTap: () {
            context.read<ChoosingPageProvider>().SelectProfession(Profession);
          },
        ),
      ),
    );
  }
}
