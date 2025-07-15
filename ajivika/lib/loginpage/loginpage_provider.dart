import 'package:ajivika/contractorsection/bottom_navbar/contractor_navbar.dart';
import 'package:ajivika/workersection/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'choosing_page.dart';

class ChoosingPageProvider extends ChangeNotifier {
  String _selected_profession = "";

  void SelectProfession(String profession) {
    _selected_profession = profession;
    notifyListeners();
  }

  void emptyprofession() {
    _selected_profession = "";
  }

  String get selected_profession => _selected_profession;
  Future<void> finaliseprofession() async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(MyApp.USER_PROFESSION_KEY, selected_profession);
  }
}

class PhoneNoProvider extends ChangeNotifier {
  var _sendotploading = false;

  String _number = '';

  Future<void> finalisenumber() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(MyApp.ISVERIFIEDKEY, true);
    pref.setString(MyApp.USERPHONEKEY, '91${number}');
  }

  Future<void> CheckProfile(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    final usernumber = pref.getString(MyApp.USERPHONEKEY);
    final supabase = Supabase.instance.client;
    final profile = await supabase
        .from('profiles')
        .select()
        .eq('phone', usernumber!)
        .maybeSingle();
    print("what are we getting : $profile");
    if (profile == null) {
      Navigator.pushReplacement(
        (context),
        MaterialPageRoute(builder: (context) => choosing_page()),
      );
    } else {
      pref.setBool(MyApp.ISLOGGEDKEY, true);
      pref.setString(MyApp.USERNAMEKEY, profile['fullname']);
      pref.setString(MyApp.USER_PROFESSION_KEY, profile['profession']);
      pref.setString(MyApp.USER_CITY, profile['city']);
      pref.setDouble(MyApp.USER_LATITUDE, profile['latitude']);
      pref.setDouble(MyApp.USER_LONGITUDE, profile['longitude']);

      if (profile['profession'] == 'Worker') {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => worker_bottom_navbar(
              currlat: profile['latitude'],
              currlong: profile['longitude'],
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => contractor_bottom_navbar(
              currlat: profile['latitude'],
              currlong: profile['longitude'],
            ),
          ),
        );
      }
    }
  }

  void setno(String value) {
    _number = value;
    notifyListeners();
  }

  String get number => _number;
  bool checkno() {
    if (_number.toString().trim().length == 10) {
      return true;
    } else {
      return false;
    }
  }

  void onloading() {
    _sendotploading = true;
    notifyListeners();
  }

  void offlaoding() {
    _sendotploading = false;
    notifyListeners();
  }

  bool get sendotploading => _sendotploading;
}

class NamePageProvider extends ChangeNotifier {
  String _name = '';
  String _city = '';
  double? _lat;
  double? _long;

  double get lat => _lat!;
  double get long => _long!;
  String get city => _city;
  set lat(double value) => _lat = value;
  set long(double value) => _long = value;
  set city(String value) => _city = value;

  void setname(String name) {
    _name = name;
    notifyListeners();
  }

  String get name => _name;
  Future<void> finalisenameandcity() async {
    var pref = await SharedPreferences.getInstance();

    pref.setString(MyApp.USERNAMEKEY, _name);
    pref.setString(MyApp.USER_CITY, _city);
    pref.setDouble(MyApp.USER_LATITUDE, _lat!);
    pref.setDouble(MyApp.USER_LONGITUDE, _long!);
    pref.setBool(MyApp.ISLOGGEDKEY, true);
  }

  bool checkstring() {
    if (_name.toString().trim().isNotEmpty && _lat != null && _long != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> SaveProfile(BuildContext context) async {
    var pref = await SharedPreferences.getInstance();
    final name = await pref.getString(MyApp.USERNAMEKEY);
    final phone = await pref.getString(MyApp.USERPHONEKEY);
    final profession = await pref.getString(MyApp.USER_PROFESSION_KEY);
    final city = await pref.getString(MyApp.USER_CITY);
    final currlat = await pref.getDouble(MyApp.USER_LATITUDE);
    final currlong = await pref.getDouble(MyApp.USER_LONGITUDE);

    final supabase = Supabase.instance.client;
    final response = await supabase.from('profiles').insert({
      'fullname': name,
      'phone': phone,
      'profession': profession,
      'city': city,
      'latitude': currlat,
      'longitude': currlong,
    }).select();
    if (response.isEmpty) {
      print('Insert Error: ${response}');
    } else {
      print('Insert Success: ${response}');
      if (profession == 'Worker') {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) =>
                worker_bottom_navbar(currlat: currlat!, currlong: currlong!),
          ),
        );
      } else {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => contractor_bottom_navbar(
              currlat: currlat!,
              currlong: currlong!,
            ),
          ),
        );
      }
    }
  }
}
