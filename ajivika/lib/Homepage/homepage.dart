import 'dart:convert';
import 'package:ajivika/Homepage/homepage_provider.dart';
import 'package:ajivika/database/remote/jobdataDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../languagepage/language_page.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  double currlat = 25.61;

  double currlong = 85.15;

  Future<void> onselectedPin(Map<String, dynamic> marker) async {
    context.read<HomepageProvider>().getPlaceName(
      marker['lat'],
      marker['long'],
    );
    context.read<HomepageProvider>().selectcurrpin(marker);
    showModalBottomSheet(
      context: (context),
      builder: (context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Job Description".tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Text(
                  "Address :".tr,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    context.watch<HomepageProvider>().placename,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Text(
                  "Detail :".tr,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(marker["desc"], style: TextStyle(fontSize: 15)),
                ),
                Text(
                  "Posted by :".tr,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    marker["postedby"],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 5,
                      color: Colors.amberAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Wage :"),
                            Text("${marker["wage"]}"),
                            Text("per day"),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      color: Colors.lightGreen,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("No of Workers required :"),
                            Text("${marker["nol"]}"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2667FF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Apply for this",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.send_rounded, color: Colors.white),
                      ],
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

  List<Map<String, dynamic>> AllJobs = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setinitialjobs();
    });
  }

  Future<void> setinitialjobs() async {
    AllJobs = await JobDB().AllJobPinPoints;
    setState(() {});
    print("Fetched jobs: $AllJobs");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageProvider>(
      builder: (ctx, provider, __) {
        return Scaffold(
          body: Column(
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

              //body
              Expanded(
                child: FlutterMap(
                  mapController: provider.mapController,
                  options: MapOptions(
                    initialCenter: LatLng(currlat, currlong),
                    initialZoom: 10,
                    onTap: (tapPosition, point) {
                      provider.selectcurrpin(null);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: AllJobs.map((markers) {
                        return Marker(
                          height: 80,
                          width: 80,
                          point: LatLng(markers['lat'], markers['long']),
                          child: GestureDetector(
                            onTap: () {
                              onselectedPin(markers);
                            },
                            child: Icon(
                              Icons.pin_drop,
                              color:
                                  provider.selectedpin?['id'] == markers['id']
                                  ? Colors.red
                                  : Colors.blue,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              provider.getcurrlocation();
            },
            child: Icon(Icons.my_location),
          ),
        );
      },
    );
  }
}
