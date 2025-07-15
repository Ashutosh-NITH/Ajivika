import 'dart:convert';
import 'package:ajivika/Profilepage/ProfilePageProvider.dart';
import 'package:ajivika/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../database/remoteDB/jobdataDB.dart';
import '../../languagepage/language_page.dart';
import 'applyforjob.dart';
import 'homepage_provider.dart';

class homepage extends StatefulWidget {
  final double currlat;
  final double currlong;
  homepage({required this.currlat, required this.currlong});
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
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
    context.read<HomepageProvider>().getworkersdata();
    context.read<HomepageProvider>().FetchAllAppliedJobs();
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
              Container(height: 20, color: Colors.white),

              //body
              Expanded(
                child: FlutterMap(
                  mapController: provider.mapController,
                  options: MapOptions(
                    initialCenter: LatLng(widget.currlat, widget.currlong),
                    initialZoom: 10,
                    onTap: (tapPosition, point) {
                      provider.selectcurrpin(null);
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=akmleE6JVaxjmodDaG0K",
                    ),
                    MarkerLayer(
                      markers: AllJobs.map((markers) {
                        return Marker(
                          height: 80,
                          width: 80,
                          point: LatLng(markers['lat'], markers['long']),
                          child: GestureDetector(
                            onTap: () async {
                              await onselectedPin(markers, ctx);
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
