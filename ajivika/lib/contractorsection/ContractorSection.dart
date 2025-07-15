import 'package:ajivika/contractorsection/Homepage/ViewDetails.dart';
import 'package:ajivika/contractorsection/contractor_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ContractorSection extends StatefulWidget {
  @override
  State<ContractorSection> createState() => _ContractorSectionState();
}

class _ContractorSectionState extends State<ContractorSection> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    context.read<ContractorSectionProvider>().getAlljobs();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContractorSectionProvider>(
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
                  "All your History".tr,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Container(color: Colors.white, height: 20),
              //main list
              provider.All_job_posts_history.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
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
                                                  "${provider.All_job_posts_history[index]['nol']}",
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
                                                  "${provider.All_job_posts_history[index]['original_nol']}",
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${provider.All_job_posts_history[index]['address']}",
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
                                                "${provider.All_job_posts_history[index]['desc']}",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                  "₹ ${provider.All_job_posts_history[index]['wage']}",
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
                                          "${provider.All_job_posts_history[index]['status']}",
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
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      (context),
                                      MaterialPageRoute(
                                        builder: (context) => ViewDetails(
                                          jobid: provider
                                              .All_job_posts_history[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text("View Details"),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(thickness: 2);
                        },
                        itemCount: provider.All_job_posts_history.length,
                      ),
                    )
                  : Text("You have posted no jobs yet "),
            ],
          ),
        );
      },
    );
  }
}
