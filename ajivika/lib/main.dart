import 'package:ajivika/bottom_navbar/bottom_navbar.dart';
import 'package:ajivika/languagepage/language_page.dart';
import 'package:ajivika/languagepage/language_page_provider.dart';
import 'package:ajivika/loginpage/choosing_page.dart';
import 'package:ajivika/loginpage/loginpage_provider.dart';
import 'package:ajivika/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'languagepage/localeString.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

    var data = await SharedPreferences.getInstance();
    final MyLang = data.getString("LanguageCode") ?? 'en';
    final MyCountry = data.getString("Country") ?? 'US';


  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => language_page_provider()),
    ChangeNotifierProvider(create: (context)=>ChoosingPageProvider()),
  ], child: MyApp(MyLang: MyLang, MyCountry: MyCountry),
  ));


}

class MyApp extends StatelessWidget {
  final String MyLang;
  final String MyCountry;
  MyApp({required this.MyLang, required this.MyCountry});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      translations: localeString(),
      locale: Locale(MyLang, MyCountry),
      title: 'Ajivika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff1076e5),),
      ),
      home: splash_screen(),
    );
  }
}