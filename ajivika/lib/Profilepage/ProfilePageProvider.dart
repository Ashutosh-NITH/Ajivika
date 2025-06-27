import 'package:ajivika/main.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePageProvider extends ChangeNotifier {
  String _name = "";
  String _profession = "";
  String _phone = "";
  String get name => _name;
  String get profession => _profession;
  String get phone => _phone;
  Future<void> initiliseinfo() async {
    final pref = await SharedPreferences.getInstance();
    var username = pref.getString(MyApp.USERNAMEKEY);
    var userprofession = pref.getString(MyApp.USER_PROFESSION_KEY);
    var usernumber = pref.getString(MyApp.USERPHONEKEY);
    _name = username!;
    _profession = userprofession!;
    _phone = usernumber!;
    notifyListeners();
  }
}
