import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationbyOTP {
  static final SupabaseClient _supabase = Supabase.instance.client;

  static Future<bool> sendOtp({required PhoneNumber}) async {
    try {
      await _supabase.auth.signInWithOtp(phone: PhoneNumber);
      return true;
    } catch (e) {
      print("Unable to send OTP due to : $e");
      return false;
    }
  }

  static Future<bool> VerifyOTP({required PhoneNumber, required OTP}) async {
    try {
      final response = await _supabase.auth.verifyOTP(
        type: OtpType.sms,
        phone: PhoneNumber,
        token: OTP,
      );
      if (response.user != null) {
        print("reponse : $response");
        print("response.user : $response.user");
        return true;
      } else {
        print("OTP verification failed ");
        return false;
      }
    } catch (e) {
      print("Unable to verify OTP: $e");
      return false;
    }
  }
}
