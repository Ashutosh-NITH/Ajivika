import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../languagepage/language_page.dart';

class homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // appbar
          Container(
            margin: EdgeInsets.only(top: 45.0),
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
                      Text("Help", style : TextStyle(color: Color(0xff2667FF),),)
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
                          Text("language" ,  style : TextStyle(color: Color(0xff2667FF),)),
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

          //body
        ],
      ),
    );
  }
  
}