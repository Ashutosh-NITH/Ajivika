import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../languagepage/language_page.dart';
import '../contractor_provider.dart';

class AddJob extends StatelessWidget {
  final String MapboxAccessToken;

  AddJob({required this.MapboxAccessToken});
  TextEditingController _addressquerycontroller = TextEditingController();
  double? job_lat;
  double? job_long;

  String? address;

  Future<void> getcoordinates(String comleteaddress) async {
    final Url = Uri.parse(
      "https://api.mapbox.com/search/geocode/v6/forward?q=${comleteaddress}&access_token=$MapboxAccessToken",
    );
    final response = await http.get(Url);
    print("Suggestion response : $response");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      job_long = data['features'][0]['properties']['coordinates']['longitude'];
      job_lat = data['features'][0]['properties']['coordinates']['latitude'];
    } else {
      throw Exception("failed to load suggestion");
    }
  }

  Future<List<String>> fetchsuggestion(String query) async {
    final Url = Uri.parse(
      "https://api.mapbox.com/search/geocode/v6/forward?q=${query}&proximity=85.137764,25.609907&access_token=$MapboxAccessToken&autocomplete=true&limit=5",
    );
    final response = await http.get(Url);
    print("Suggestion response : $response");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final features = data['features'] as List;
      return features.map<String>((suggestion) {
        return suggestion['properties']['full_address'];
      }).toList();
    } else {
      throw Exception("failed to load suggestion");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractorHomepageProvider>(
      builder: (ctx, provider, __) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                // appbar
                Container(color: Colors.white, height: 50),
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
                Container(height: 20, color: Colors.white),
                Text(
                  "Post Jobs",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 30),
                ),

                SizedBox(height: 30),

                //search location
                TypeAheadField<String>(
                  builder: (context, controller, focusNode) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Search Location',
                        hintText: 'Enter address',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xff2667FF)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                    );
                  },
                  controller: _addressquerycontroller,
                  itemBuilder: (context, suggestion) {
                    return ListTile(title: Text(suggestion));
                  },
                  onSelected: (selected) {
                    _addressquerycontroller.text = selected;
                    address = selected;
                    getcoordinates(selected);
                  },
                  suggestionsCallback: (query) {
                    return fetchsuggestion(query);
                  },
                ),
                SizedBox(height: 20),

                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Enter wage\nper day :",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              //wage
                              Container(
                                width: 80,
                                child: TextField(
                                  controller: provider.wage_controller,
                                  keyboardType: TextInputType.number,

                                  decoration: InputDecoration(
                                    prefixText: "₹  ",

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Color(0xff2667FF),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Enter no of\nwokers required :",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                              //nol
                              Container(
                                width: 80,
                                child: TextField(
                                  controller: provider.nol_controller,
                                  keyboardType: TextInputType.number,

                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Color(0xff2667FF),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          //description
                          TextField(
                            controller: provider.desc_controller,
                            minLines: 4,
                            maxLines: 7,
                            decoration: InputDecoration(
                              labelText: "Enter Description",
                              hintText:
                                  "Tell us in detail about job and facility that you provide",

                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color(0xff2667FF),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //post job button
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final nol =
                          int.tryParse(
                            provider.nol_controller.text.toString().trim(),
                          ) ??
                          0;
                      final wage =
                          int.tryParse(
                            provider.wage_controller.text.toString().trim(),
                          ) ??
                          0;
                      final desc = provider.desc_controller.text
                          .toString()
                          .trim();

                      print(
                        "nol : $nol , wage : $wage ,  desc : $desc , lat : $job_lat ,long : $job_long",
                      );
                      if (job_lat == null || job_long == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please choose working location"),
                          ),
                        );
                      } else if (wage < 400) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter wage minimum of 400"),
                          ),
                        );
                      } else if (nol == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please enter atleast one worker"),
                          ),
                        );
                      } else if (desc.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter description")),
                        );
                      } else {
                        bool check = await provider.PostJob(
                          job_long!,
                          job_lat!,
                          wage,
                          nol,
                          desc,
                          address!,
                        );
                        if (check) {
                          job_long == null;
                          job_lat == null;
                          _addressquerycontroller.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Job Posted Successfully")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("error while posting job")),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2667FF),
                    ),
                    child: Text(
                      "Post Job",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
