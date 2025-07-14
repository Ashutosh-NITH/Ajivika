import 'package:supabase_flutter/supabase_flutter.dart';

class JobDB {
  List<Map<String, dynamic>>? _AllJobPinPoints;

  Future<List<Map<String, dynamic>>> fetchalljobs() async {
    print("fetch all jobs fn called");
    final response = await Supabase.instance.client
        .from('job_posts')
        .select()
        .eq('status', 'active');
    if (response.isNotEmpty) {
      print("response is not empty : $response");
      return response;
    } else {
      print("response is  empty : $response");
      return [];
    }
  }

  Future<void> setjobs() async {
    _AllJobPinPoints = await fetchalljobs();
    print("setjobs fn called");
  }

  Future<List<Map<String, dynamic>>> get AllJobPinPoints async {
    print("get all job pinpoints fn called");
    await setjobs();
    return _AllJobPinPoints!;
  }
}
