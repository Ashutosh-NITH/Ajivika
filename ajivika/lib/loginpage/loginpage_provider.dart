import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosingPageProvider extends ChangeNotifier {
  String selected_profession = "";

  void SelectProfession(String profession) {
    selected_profession = profession;
    notifyListeners();
  }
}

class OTPpageprovider extends ChangeNotifier {
  var checkotploading = false;
  var clearotp = false;

  void onloading() {
    checkotploading = true;
    notifyListeners();
  }

  void offloading() {
    checkotploading = false;
    notifyListeners();
  }

  void clearotpfield() {
    clearotp = true;
    notifyListeners();
  }
}

class PhoneNoProvider extends ChangeNotifier {
  var sendotploading = false;

  void onloading() {
    sendotploading = true;
    notifyListeners();
  }

  void offlaoding() {
    sendotploading = false;
    notifyListeners();
  }
}
