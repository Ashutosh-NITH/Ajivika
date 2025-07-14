import 'package:ajivika/workersection/WorkerSectionProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class WorkerSection extends StatefulWidget {
  @override
  State<WorkerSection> createState() => _WorkerSectionState();
}

class _WorkerSectionState extends State<WorkerSection> {
  @override
  void initState() {
    context.read<WorkerSectionProvider>().fetchalljobs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkerSectionProvider>(
      builder: (ctx, provider, __) {
        return Scaffold(
          body: Column(
            children: [
              Container(color: Colors.white, height: 50),
              //heading
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Text(
                  "All your applied history".tr,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(color: Colors.white, height: 20),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(),
                              Text(
                                "${provider.all_applied_job_posts[index]['job_posts']['postedby']}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Current Jobs Available :",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${provider.all_applied_job_posts[index]['job_posts']['nol']}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total job posted :",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${provider.all_applied_job_posts[index]['job_posts']['original_nol']}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          //main
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${provider.all_applied_job_posts[index]['job_posts']['address']}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                                SizedBox(height: 10),

                                //desc
                                Container(
                                  height: 50,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      "${provider.all_applied_job_posts[index]['job_posts']['desc']}",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                color: Colors.yellowAccent.shade400,
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Wage :",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "₹ ${provider.all_applied_job_posts[index]['job_posts']['wage']}",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "Date Posted :",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Current Status :",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${provider.all_applied_job_posts[index]['job_posts']['status']}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 2);
                  },
                  itemCount: provider.all_applied_job_posts.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
