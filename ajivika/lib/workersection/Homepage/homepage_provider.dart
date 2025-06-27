import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomepageProvider extends ChangeNotifier {
  String placename = '';
  final String _APIKEY = '8nkP9SE407E3CQVSxcBX';
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
}
