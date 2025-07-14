import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'homepage_provider.dart';

Future<void> onselectedPin(
  Map<String, dynamic> marker,
  BuildContext context,
) async {
  context.read<HomepageProvider>().getworkersdata();
  context.read<HomepageProvider>().FetchAllAppliedJobs();
  context.read<HomepageProvider>().getPlaceName(marker['lat'], marker['long']);
  context.read<HomepageProvider>().selectcurrpin(marker);
  showModalBottomSheet(
    context: (context),
    builder: (context) {
      return Consumer<HomepageProvider>(
        builder: (context, provider, __) {
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Text(
                    "Address :".tr,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      marker['address'],
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

                  //apply button
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: ElevatedButton(
                      onPressed: () {
                        provider.allappliedjobs.any(
                              (job) => job['job_id'] == marker['id'],
                            )
                            ? showDialog(
                                context: (context),
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(
                                      "You have Already appplied for this job ",
                                    ),
                                  );
                                },
                              )
                            : provider.Applyforthisjob(marker['id']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            provider.allappliedjobs.any(
                              (job) => job['job_id'] == marker['id'],
                            )
                            ? Colors.grey
                            : Color(0xff2667FF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.allappliedjobs.any(
                                  (job) => job['job_id'] == marker['id'],
                                )
                                ? "Applied"
                                : provider.isapplying
                                ? "applying "
                                : "Apply for this",
                            style: TextStyle(color: Colors.white),
                          ),

                          provider.allappliedjobs.any(
                                (job) => job['job_id'] == marker['id'],
                              )
                              ? Icon(Icons.check_circle, color: Colors.white)
                              : provider.isapplying
                              ? LoadingAnimationWidget.flickr(
                                  leftDotColor: Colors.white,
                                  rightDotColor: Colors.blue,
                                  size: 20,
                                )
                              : Icon(Icons.send_rounded, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
