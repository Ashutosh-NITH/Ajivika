import 'package:ajivika/utility.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../languagepage/language_page.dart';
import 'loginpage_provider.dart';

class EnterNamePage extends StatelessWidget {
  List<Map<String, dynamic>> _cities = [
    {'name': "Hamirpur , Himachal", 'lat': 31.690783, 'long': 76.517715},
    {'name': "Dharamshala , Himachal", 'lat': 32.219044, 'long': 76.323402},
    {'name': "Kullu , Himachal", 'lat': 31.957851, 'long': 77.109459},
    {'name': "Chamba , Himachal", 'lat': 32.5550, 'long': 76.1258},
    {'name': "Una , Himachal", 'lat': 31.4694, 'long': 76.2711},
    {'name': "Shimla , Himachal", 'lat': 31.1048, 'long': 77.1734},
    {'name': "Kangra , Himachal", 'lat': 32.1007, 'long': 76.2691},
    {'name': "Mandi , Himachal", 'lat': 31.5892, 'long': 76.9182},
    {'name': "Palampur , Himachal", 'lat': 32.1104, 'long': 76.5365},
    {'name': "Patna , Bihar", 'lat': 25.612677, 'long': 85.158875},
    {'name': "Kolkata , West Bengal", 'lat': 22.5726, 'long': 88.3639},
    {'name': "Moradabad , UP", 'lat': 28.8386, 'long': 78.7733},
    {'name': "Agra , UP", 'lat': 27.1767, 'long': 78.0081},
  ];
  List<String> city = [
    "Hamirpur , Himachal",
    'Dharamshala , Himachal',
    'Kullu, Himachal',
    'Chamba , Himachal',
    'Una , Himachal',
    'Shimla , Himachal',
    'Kangra , Himachal',
    'Dharamshala , Himachal',
    'Mandi , Himachal',
    'Palampur , Himachal',
    'Patna , Bihar',
    'Kolkata , West Bengal',
    'Moradabad , UP',
    'Agra , UP',
  ];
  @override
  Widget build(BuildContext context) {
    final dropDownKey = GlobalKey<DropdownSearchState>();
    return Scaffold(
      body: Consumer<NamePageProvider>(
        builder: (ctx, provider, __) {
          return Column(
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
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'name page heading line 1'.tr,
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
                    'name page heading line 2'.tr,
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
                child: Column(
                  children: [
                    //name
                    Container(
                      margin: EdgeInsets.only(
                        top: 40.0,
                        left: 20.0,
                        right: 20.0,
                      ),
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

                    SizedBox(height: 20),
                    //city
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: DropdownSearch<String>(
                        key: dropDownKey,
                        enabled: true,
                        items: (_, __) => city,
                        onChanged: (value) {
                          print("onchanged $value");
                          final selectedCity = _cities.firstWhere(
                            (eachcity) => eachcity['name'] == value,
                          );
                          if (selectedCity.isNotEmpty) {
                            print("Selected City: ${selectedCity['name']}");
                            print("Latitude: ${selectedCity['lat']}");
                            print("Longitude: ${selectedCity['long']}");
                            provider.city = selectedCity['name'];
                            provider.lat = selectedCity['lat'];
                            provider.long = selectedCity['long'];
                          } else {
                            print("City not found in _cities list");
                          }
                        },

                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            label: Text("Enter City".tr),
                            hintText: "Enter City".tr,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff2667FF)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Color(0xff2667FF)),
                            ),
                          ),
                        ),
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              label: Text("Search City".tr),
                              hintText: "Enter City".tr,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0xff2667FF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0xff2667FF),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //submit button
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (provider.checkstring()) {
                      showDialog(
                        barrierDismissible: false,
                        context: (context),
                        builder: (context) {
                          return Center(
                            child: LoadingAnimationWidget.flickr(
                              leftDotColor: Colors.white,
                              rightDotColor: Colors.blue,
                              size: 50,
                            ),
                          );
                        },
                      );
                      provider.finalisenameandcity();
                      provider.SaveProfile(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please Enter Your Name and place".tr),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.checkstring()
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
          );
        },
      ),
    );
  }
}
