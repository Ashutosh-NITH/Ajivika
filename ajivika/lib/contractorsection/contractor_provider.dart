import 'package:ajivika/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContractorHomepageProvider extends ChangeNotifier {
  TextEditingController _wage_controller = TextEditingController();

  TextEditingController _nol_controller = TextEditingController();
  TextEditingController _description_controller = TextEditingController();

  TextEditingController get wage_controller => _wage_controller;
  TextEditingController get nol_controller => _nol_controller;
  TextEditingController get desc_controller => _description_controller;

  List<Map<String, dynamic>> _alljobmarkers = [];
  List<Map<String, dynamic>> get alljobmarkers => _alljobmarkers;
  Map<String, Map<String, dynamic>> _annotaionMetadata = {};
  Map<String, Map<String, dynamic>> get annotaionMetadata => _annotaionMetadata;

  String _phone = '';
  String get phone => _phone;
  String _name = '';
  String get name => _name;

  Future<void> initiliseuserdata() async {
    final pref = await SharedPreferences.getInstance();
    _phone = pref.getString(MyApp.USERPHONEKEY)!;
    _name = pref.getString(MyApp.USERNAMEKEY)!;
  }

  Future<void> getinitialjobs() async {
    await initiliseuserdata();
    final supabase = await Supabase.instance.client;
    final response = await supabase
        .from('job_posts')
        .select()
        .eq('contractor_phone', _phone)
        .eq('status', 'active');
    _alljobmarkers = response;
    if (response.isNotEmpty) {
      print("response is not empty : $response");
      _alljobmarkers = response;
    } else {
      print("response is  empty : $response");
    }
    notifyListeners();
  }

  Future<bool> getAlljobs() async {
    final supabase = await Supabase.instance.client;
    final response = await supabase
        .from('job_posts')
        .select()
        .eq('contractor_phone', _phone)
        .eq('status', 'active');
    if (response.isNotEmpty) {
      print("response is not empty : $response");
      _alljobmarkers = response;
      notifyListeners();
      return true;
    } else {
      print("response is  empty : $response");
      return false;
    }
  }

  Future<bool> PostJob(
    double long,
    double lat,
    int wage,
    int nol,
    String desc,
    String address,
  ) async {
    final supabase = await Supabase.instance.client;
    try {
      final response = await supabase.from('job_posts').insert({
        'lat': lat,
        'long': long,
        'wage': wage,
        'nol': nol,
        'original_nol': nol,
        'desc': desc,
        'postedby': _name,
        'contractor_phone': _phone,
        'address': address,
      });
      print("job posted successfully: $response");
      getAlljobs();
      desc_controller.clear();
      wage_controller.clear();
      nol_controller.clear();
      return true;
    } catch (e) {
      print("error while posting  ${e}");
      return false;
    }
  }
}

class ViewDetailsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _AllYourWorkers = [];
  List<Map<String, dynamic>> get AllYourWorkers => _AllYourWorkers;

  Future<void> getallyourworkers(int jobid) async {
    final supabase = await Supabase.instance.client;
    final List<Map<String, dynamic>> response = await supabase
        .from('apply_for_job')
        .select()
        .eq('job_id', jobid);
    if (response.isNotEmpty) {
      _AllYourWorkers = response;
      print("fetched");
    } else {
      print("no one applied yet");
      _AllYourWorkers = [];
    }
    notifyListeners();
  }
}

class ContractorSectionProvider extends ChangeNotifier {}
