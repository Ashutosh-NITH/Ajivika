import 'package:ajivika/contractorsection/contractor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewDetails extends StatefulWidget {
  int jobid;
  ViewDetails({required this.jobid});

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  void initState() {
    context.read<ViewDetailsProvider>().getallyourworkers(widget.jobid);
    context.read<ViewDetailsProvider>().getcurrentjobpost(widget.jobid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewDetailsProvider>(
      builder: (ctx, provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Details",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //job desc
                Text(
                  "Job Description",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //original nol
                Row(
                  children: [
                    Text(
                      "Total Workers required : ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      "${provider.selected_job_post['original_nol']}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //nol
                Row(
                  children: [
                    Text(
                      "Remaining Workers Required : ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      "${provider.selected_job_post['nol']}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //wage
                Row(
                  children: [
                    Text(
                      "Wage : ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      "${provider.selected_job_post['wage']}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //address
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Address : ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),

                    //to stop overflow
                    Expanded(
                      child: Text(
                        "${provider.selected_job_post['address']}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                //date posted
                Row(
                  children: [
                    Text(
                      "Date posted : ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      "${provider.selected_job_post['date_posted']}",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //desc
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Description : ",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    //to stop overflow
                    Expanded(
                      child: Text(
                        "${provider.selected_job_post['desc']}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // all workers details
                Text(
                  "Your Workers",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(),
                        title: Text(
                          "${provider.AllYourWorkers[index]['worker_name']}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade700,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.phone, color: Color(0xff2667FF)),
                            Text(
                              "${provider.AllYourWorkers[index]['worker_phone']}",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade700,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(thickness: 2);
                    },
                    itemCount: provider.AllYourWorkers.length,
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
