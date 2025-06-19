import 'package:ajivika/languagepage/localeString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class language_page_provider extends ChangeNotifier{
  Future<void> initial_lang() async {
    var data = await SharedPreferences.getInstance();
    selectedLang = await data.getString("LangName")?? "English";
    notifyListeners();
  }
  String selectedLang = "";
  Future<void> changed_lang (String selected , String LangCode , String LangCountry) async {
    selectedLang = selected;
    Get.updateLocale(Locale( LangCode , LangCountry));
    notifyListeners();
    var data = await SharedPreferences.getInstance();

    var langpref = data.setString("LanguageCode", LangCode);
    langpref = data.setString("Country" ,LangCountry);
    langpref = data.setString("LangName", selected);
  }

}