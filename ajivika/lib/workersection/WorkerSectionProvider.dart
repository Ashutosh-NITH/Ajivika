import 'package:ajivika/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WorkerSectionProvider extends ChangeNotifier {
  List<Map<String, dynamic>>? _all_applied_job_posts;
  List<Map<String, dynamic>> get all_applied_job_posts =>
      _all_applied_job_posts!;

  Future<void> fetchalljobs() async {
    final pref = await SharedPreferences.getInstance();
    final String _phone = pref.getString(MyApp.USERPHONEKEY)!;
    final SupabaseClient supabase = await Supabase.instance.client;

    //query
    final List<Map<String, dynamic>> response = await supabase
        .from('apply_for_job')
        .select('job_posts(*) , created_at')
        .eq('worker_phone', _phone)
        .order('created_at', ascending: false);
    if (response.isNotEmpty) {
      _all_applied_job_posts = response;
      print("response : $response");
      print("_all_applied_job_posts : $_all_applied_job_posts");

      notifyListeners();
    } else {
      print("error fetching all jobs $response");
    }
  }
}
