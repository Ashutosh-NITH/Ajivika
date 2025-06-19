import 'package:ajivika/languagepage/language_page_provider.dart';
import 'package:ajivika/textstyle/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class language_page extends StatefulWidget{

  @override
  State<language_page> createState() => _language_pageState();

}


class _language_pageState extends State<language_page> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<language_page_provider>().initial_lang();
  }

  final List<Map<String, String>> languages = [
    {"name": "English", "native": "English", "symbol": "Aa" , "langCode" : 'en', "langCountry": 'US' },
    {"name": "Hindi", "native": "हिंदी", "symbol": "आ" , "langCode" : 'hi', "langCountry": 'IN' },
    {"name": "Marathi", "native": "मराठी", "symbol": "एम" , "langCode" : 'mr', "langCountry": 'IN' },
    {"name": "Gujarati", "native": "ગુજરાતી", "symbol": "એ" , "langCode" : 'gu', "langCountry": 'IN' },
    {"name": "Telugu", "native": "తెలుగు", "symbol": "ఆ" , "langCode" : 'te', "langCountry": 'IN' },
    {"name": "Kannada", "native": "ಕನ್ನಡ", "symbol": "ಅ" , "langCode" : 'kn', "langCountry": 'IN' },
    {"name": "Bengali", "native": "বাংলা", "symbol": "আ", "langCode" : 'bn', "langCountry": 'IN'},
    {"name": "Tamil", "native": "தமிழ்", "symbol": "அ" , "langCode" : 'ta', "langCountry": 'IN'},
  ];

  @override
  Widget build(BuildContext context) {


    print("BuildContext  called");
    return Consumer<language_page_provider>(builder: (ctx , provider , __){

      print("consumer builder context called");
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      // perform action => get help => customer care
                    },
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        FaIcon(FontAwesomeIcons.headset ,  color: Color(0xff2667FF),),
                        SizedBox(width: 5,),
                        Text("help".tr, style : TextStyle(color: Color(0xff2667FF) ,),)
                      ],
                    ),
                  ),
                  FaIcon(FontAwesomeIcons.volumeHigh ,color: Color(0xff2667FF),),
                ],
              ),
            ),
            Container( color: Colors.white, height: 20,),

            Container(color: Colors.white,width: double.infinity, margin: EdgeInsets.only(left: 20.0) ,
                child: Text("Pick your".tr , style: TextStyle(fontFamily: "Poppins", fontSize: 25, fontWeight: FontWeight.bold,),)
            ),
            Container(color: Colors.white,width: double.infinity, margin: EdgeInsets.only(left: 20.0) ,
                child: Text("preferred language".tr,style: TextStyle(fontFamily: "Poppins",fontSize: 25, fontWeight: FontWeight.bold,),)
            ),
            Container( color: Colors.white, height: 20,),

            //body language  container
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 5.0, right: 5.0),
                child: GridView.builder(
                    itemCount: languages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.6,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (ctx, index){
                      print("item builder context called");
                      return getlangGrid(
                        ctx,
                        languages[index]["name"].toString(),
                        languages[index]["native"].toString() ,
                        languages[index]["symbol"].toString() ,
                        languages[index]["langCode"].toString() ,
                        languages[index]["langCountry"].toString() ,

                      );
                    }
                ),
              ),
            ),


            //continue button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xff2667FF),
                  foregroundColor: Colors.white,
                ), child: Text("Continue".tr),
              ),
            ),
          ],
        ),

      );
    });
  }

  Widget getlangGrid(BuildContext context , String lang, String native,  String symb ,String LangCode, String LangCountry) {
    return GridTile(child:
    InkWell(
      onTap: (){
        context.read<language_page_provider>().changed_lang(lang , LangCode , LangCountry);
      },
      child: Container(

        margin: EdgeInsets.all(5.0),
        height: 100,
        decoration: BoxDecoration(
          color: context.watch<language_page_provider>().selectedLang == lang?  Color(0xffe9f6ff) : Colors.white ,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.watch<language_page_provider>().selectedLang == lang ?Color(0xff2667FF):Colors.grey,
            width: 1,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$lang \n$native", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
              Text(symb, style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    )
    );
  }
}