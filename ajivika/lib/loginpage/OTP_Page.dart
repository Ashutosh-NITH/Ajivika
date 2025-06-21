import 'package:ajivika/loginpage/Phone_Number_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../languagepage/language_page.dart';
import 'choosing_page.dart';

class OTP_Page extends StatelessWidget{
  String PhoneNumber;
  OTP_Page({required this.PhoneNumber});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(
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
                   onTap: (){
                     // perform action => get help => customer care
                   },
                   child: Row(
                     children: [
                       SizedBox(width: 20,),
                       FaIcon(FontAwesomeIcons.headset ,  color: Color(0xff2667FF),),
                       SizedBox(width: 5,),
                       Text("help".tr, style : TextStyle(color: Color(0xff2667FF),),)
                     ],
                   ),
                 ),
                 // right part => voice and language
                 Row(
                     children: [
                       InkWell(
                           onTap: (){
                             // perform action => speak on tap of audio icon
                           },
                           child: FaIcon(FontAwesomeIcons.volumeHigh , color: Color(0xff2667FF),)),
                       SizedBox(width: 25,),
                       InkWell(
                         onTap: (){
                           Navigator.push((context), MaterialPageRoute(builder: (context)=>language_page()));
                         },child: Row(
                         children: [
                           Text("language".tr ,  style : TextStyle(color: Color(0xff2667FF),)),
                           SizedBox(width: 5,),
                           FaIcon(FontAwesomeIcons.angleDown ,  color: Color(0xff2667FF),)
                         ],
                       ),
                       ),
                       SizedBox(width: 20,),
                     ]
                 )
               ],
             ),
           ),
           Container(color: Colors.white, height: 40),

           Container(
               color: Colors.white,
               width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.only(left: 20.0),
                 child: Text("Please enter OTP".tr, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
               )
           ),


           Container(
             color: Colors.white,
             width: double.infinity,
             child: Padding(
               padding: const EdgeInsets.only(left: 20.0),
               child: Row(
                 children: [
                   Text("sent at +91 ".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,  color: Colors.grey.shade600,fontFamily: "Poppins"),),
                   Text("$PhoneNumber".tr, style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600,fontFamily: "Poppins"),),
                   SizedBox(width: 10,),
                   InkWell(
                     onTap: (){
                       Navigator.pushReplacement((context), MaterialPageRoute(builder: (context)=>Phone_Number_Page()));
                     },
                     child: Icon(Icons.edit , color: Colors.green,)),
                 ],
               ),
             ),
           ),



           Container(color: Colors.white, height: 10),

           Expanded(
             child: Container(
               margin: EdgeInsets.only(top: 40.0 ,left: 20.0 , right: 20.0 ),
               child: OtpTextField(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 fillColor: Colors.white,

                 filled: true,
                 numberOfFields: 6,
                 showFieldAsBox: true,
                 borderColor:  Color(0xff2667FF),
                 focusedBorderColor:  Colors.green,
                 enabledBorderColor: Color(0xff2667FF),
                 fieldWidth: 45,
                 borderRadius: BorderRadius.circular(11),
                 onSubmit: (OTP){
                   print(OTP);
                   // verify otp => then navigate
                 },
               ),
             ),
           ),
           //submit button
           Container(
             width: double.infinity,
             margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
             child: ElevatedButton(
               onPressed: () {
                 Navigator.push((context), MaterialPageRoute(builder: (context)=>choosing_page()));
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: Color(0xff2667FF) ,
                 foregroundColor: Colors.white,
               ), child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                     "Next".tr,
                     style:
                     TextStyle(fontSize: 20, fontFamily: "Poppins",),
                   ),
                 ),
               ],
             ),
             ),
           ),
         ]
     ),
   );
  }

}