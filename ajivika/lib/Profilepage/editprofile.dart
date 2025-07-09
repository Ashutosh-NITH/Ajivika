import 'package:ajivika/Profilepage/ProfilePageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showcustombottomsheet(BuildContext context) {
  TextEditingController _textEditingController = TextEditingController(
    text: context.read<ProfilePageProvider>().name,
  );
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Change name",
              style: TextStyle(fontFamily: "Poppins", fontSize: 30),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Color(0xff2667FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.green.shade400),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  String newname = _textEditingController.text
                      .toString()
                      .trim();
                  context.read<ProfilePageProvider>().ChangeName(newname);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff2667FF),
                ),
                child: Text(
                  "Change",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
