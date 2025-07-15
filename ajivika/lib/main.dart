import 'package:ajivika/Profilepage/ProfilePageProvider.dart';
import 'package:ajivika/contractorsection/contractor_provider.dart';
import 'package:ajivika/languagepage/language_page_provider.dart';
import 'package:ajivika/loginpage/loginpage_provider.dart';
import 'package:ajivika/splash_screen/splash_screen.dart';
import 'package:ajivika/workersection/Homepage/homepage_provider.dart';
import 'package:ajivika/workersection/WorkerSectionProvider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'languagepage/localeString.dart';
import 'loginpage/enter_name_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://syzpkdxjwndyzhdhpebs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5enBrZHhqd25keXpoZGhwZWJzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA0ODk4MTQsImV4cCI6MjA2NjA2NTgxNH0.6JXbKWT1oK3QFzFPcqWqoJmZ094I3nj4JyakyVX9Xjw',
  );
  var data = await SharedPreferences.getInstance();
  final MyLang = data.getString("LanguageCode") ?? 'en';
  final MyCountry = data.getString("Country") ?? 'US';

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => language_page_provider()),
        ChangeNotifierProvider(create: (context) => ChoosingPageProvider()),
        ChangeNotifierProvider(create: (context) => PhoneNoProvider()),
        ChangeNotifierProvider(create: (context) => HomepageProvider()),
        ChangeNotifierProvider(create: (context) => NamePageProvider()),
        ChangeNotifierProvider(create: (context) => ProfilePageProvider()),
        ChangeNotifierProvider(
          create: (context) => ContractorHomepageProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ViewDetailsProvider()),
        ChangeNotifierProvider(create: (context) => WorkerSectionProvider()),
        ChangeNotifierProvider(
          create: (context) => ContractorSectionProvider(),
        ),
      ],
      child: MyApp(MyLang: MyLang, MyCountry: MyCountry),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final ISVERIFIEDKEY = "isverified";
  static final ISLOGGEDKEY = "islogggedin";
  static final USERPHONEKEY = "UserPhoneNumber";
  static final USERNAMEKEY = "UserName";
  static final USER_PROFESSION_KEY = "UserProfession";
  static final USER_CITY = 'UserCity';
  static final USER_LATITUDE = 'UserCityLatitude';
  static final USER_LONGITUDE = 'UserCityLongitude';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff1076e5)),
      ),
      home: splash_screen(),
    );
  }
}
