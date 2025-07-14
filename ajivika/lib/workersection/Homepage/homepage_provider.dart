import 'dart:convert';
import 'dart:core';
import 'package:ajivika/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomepageProvider extends ChangeNotifier {
  String _phone = '';
  String get phone => _phone;
  String _worker_name = '';
  String get worker_name => _worker_name;
  List<Map<String, dynamic>> allappliedjobs = [];
  bool _isapplying = false;
  bool get isapplying => _isapplying;
  Future<void> getworkersdata() async {
    final pref = await SharedPreferences.getInstance();
    _phone = await pref.getString(MyApp.USERPHONEKEY)!;
    _worker_name = await pref.getString(MyApp.USERNAMEKEY)!;
    notifyListeners();
  }

  Future<void> FetchAllAppliedJobs() async {
    final supabase = await Supabase.instance.client;
    allappliedjobs = await supabase
        .from('apply_for_job')
        .select()
        .eq('worker_phone', _phone);
    print("all applied jobs : $allappliedjobs");
    notifyListeners();
  }

  String placename = '';
  final String _APIKEY = 'akmleE6JVaxjmodDaG0K';
  MapController mapController = MapController();

  Future<void> getPlaceName(double lat, double long) async {
    final url = Uri.parse(
      'https://api.maptiler.com/geocoding/$long,$lat.json?key=$_APIKEY',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final object = json.decode(response.body);
      print(object['features'][0]['place_name']);
      placename = object['features'][0]['place_name'];
      notifyListeners();
    } else {
      print("unable to fetch api");
    }
    notifyListeners();
  }

  Map<String, dynamic>? _selectedpin;
  Map<String, dynamic>? get selectedpin => _selectedpin;

  Future<void> selectcurrpin(Map<String, dynamic>? marker) async {
    _selectedpin = marker;
    notifyListeners();
  }

  Future<void> getcurrlocation() async {
    var permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position);
    mapController.move(
      LatLng(position.latitude, position.longitude),
      mapController.camera.zoom,
    );
    notifyListeners();
  }

  Future<void> Applyforthisjob(int jobid) async {
    _isapplying = true;
    notifyListeners();
    final supabase = await Supabase.instance.client;
    try {
      final response = await supabase.from('apply_for_job').insert({
        'worker_name': worker_name,
        'worker_phone': phone,
        'job_id': jobid,
      });
      final currjob = await supabase
          .from('job_posts')
          .select('nol')
          .eq('id', jobid)
          .single();
      final int currnol = currjob['nol'];
      final update = await supabase
          .from('job_posts')
          .update({'nol': currnol - 1})
          .eq('id', jobid)
          .select()
          .single();
      print("applied successfully : $response");
      FetchAllAppliedJobs();
      _isapplying = false;
      notifyListeners();
    } catch (e) {
      print("caused error while applying for job : $e");
    }
  }
}
