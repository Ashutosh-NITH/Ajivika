import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoosingPageProvider extends ChangeNotifier{
  String selected_profession = "";


  void SelectProfession(String profession){
    selected_profession = profession;
    notifyListeners();
  }
}