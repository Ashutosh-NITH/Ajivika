import 'package:ajivika/contractorsection/bottom_navbar/contractor_navbar.dart';
import 'package:ajivika/workersection/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import 'OTP_Page.dart';
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
      if (profile['profession'] == 'Worker') {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(builder: (context) => worker_bottom_navbar()),
        );
      } else {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(builder: (context) => contractor_bottom_navbar()),
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

  void setname(String name) {
    _name = name;
    notifyListeners();
  }

  String get name => _name;
  Future<void> finalisename() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(MyApp.ISLOGGEDKEY, true);
    pref.setString(MyApp.USERNAMEKEY, name);
  }

  bool checkstring() {
    if (_name.toString().trim().isNotEmpty) {
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
    final supabase = Supabase.instance.client;
    final response = await supabase.from('profiles').insert({
      'fullname': name,
      'phone': phone,
      'profession': profession,
    }).select();
    if (response.isEmpty) {
      print('Insert Error: ${response}');
    } else {
      print('Insert Success: ${response}');
      if (profession == 'Worker') {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(builder: (context) => worker_bottom_navbar()),
        );
      } else {
        Navigator.pushReplacement(
          (context),
          MaterialPageRoute(builder: (context) => contractor_bottom_navbar()),
        );
      }
    }
  }
}
