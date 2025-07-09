import 'package:ajivika/database/remoteDB/profileDB.dart';
import 'package:ajivika/main.dart';
import 'package:ajivika/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePageProvider extends ChangeNotifier {
  String _name = "";
  String _profession = "";
  String _phone = "";
  String get name => _name;
  String get profession => _profession;
  String get phone => _phone;

  String _imageurl = '';
  String get imageurl => _imageurl;

  Future<void> initiliseinfo() async {
    final pref = await SharedPreferences.getInstance();
    final supabase = await Supabase.instance.client;
    _phone = pref.getString(MyApp.USERPHONEKEY)!;
    final response = await supabase
        .from('profiles')
        .select()
        .eq('phone', _phone)
        .maybeSingle();
    if (response != null) {
      pref.setString(MyApp.USERNAMEKEY, response['fullname']);
      pref.setString(MyApp.USER_PROFESSION_KEY, response['profession']);
      _name = pref.getString(MyApp.USERNAMEKEY)!;
      _profession = pref.getString(MyApp.USER_PROFESSION_KEY)!;
    } else {
      print(
        "error while accesing user profiles data from supabase => $response",
      );
    }
    CheckProfileImage();
    notifyListeners();
  }

  Future<void> LogOut(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushAndRemoveUntil(
      (context),
      MaterialPageRoute(builder: (context) => splash_screen()),
      (Route<dynamic> route) => false,
    );
    notifyListeners();
  }

  Future<void> ChangeName(String newname) async {
    print("function called $_phone");
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase
          .from('profiles')
          .update({'fullname': newname})
          .eq('phone', _phone)
          .select();
      if (response != null) {
        print("named changed successfully");
        initiliseinfo();
        notifyListeners();
      } else {
        print("No user match found : $response");
      }
    } catch (e) {
      print("error while changing name : $e");
    }
  }

  Future<void> UploadImage() async {
    final supabase = Supabase.instance.client;
    final ImagePicker picker = await ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final mimetype = lookupMimeType(image!.path);
    print("mimetype $mimetype");
    final imaginbytes = await image?.readAsBytes();
    final imagepath = "$_phone/profile";

    await supabase.storage
        .from('profiles-avatars')
        .uploadBinary(
          imagepath,
          imaginbytes!,
          fileOptions: FileOptions(upsert: true, contentType: mimetype),
        );
    String currurl = await supabase.storage
        .from('profiles-avatars')
        .getPublicUrl(imagepath);

    //very important concept
    // the url is same so we add query parameter => currtimestamp in the same url
    // https: //example.com/image.png?time=1720542345000
    _imageurl = Uri.parse(currurl)
        .replace(
          queryParameters: {
            'time': DateTime.now().millisecondsSinceEpoch.toString(),
          },
        )
        .toString();
    notifyListeners();
  }

  Future<void> CheckProfileImage() async {
    final supabase = Supabase.instance.client;
    final imagepath = "$_phone/profile";
    String currurl = await supabase.storage
        .from('profiles-avatars')
        .getPublicUrl(imagepath);
    final response = await http.get(Uri.parse(currurl));

    if (response.statusCode == 400) {
      _imageurl = '';
    } else {
      _imageurl = currurl;
    }
    notifyListeners();
  }

  Future<bool> DeleteProfileImage() async {
    final supabase = Supabase.instance.client;
    final imagepath = "$_phone/profile"; // dont use /slash here
    final response = await supabase.storage.from('profiles-avatars').remove([
      imagepath,
    ]); //  takes a list of paths

    if (response.isEmpty) {
      print("Image deleted successfully. $response");
      _imageurl = '';
      notifyListeners();
      return true;
    } else {
      print("error while deleting image $response");
      return false;
    }
  }
}
