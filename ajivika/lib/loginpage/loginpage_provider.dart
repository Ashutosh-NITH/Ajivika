import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}

class PhoneNoProvider extends ChangeNotifier {
  var _sendotploading = false;

  String _number = '';

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

  // Future<void> storename(String name) async {
  //   var response = await SharedPreferences.getInstance();
  // }

  bool checkstring() {
    if (_name.toString().trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
    notifyListeners();
  }
}
