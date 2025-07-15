import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

Future<void> makeCall(String phoneNumber) async {
  final PhoneNo = phoneNumber.replaceFirst('91', '');
  final Uri url = Uri(scheme: 'tel', path: PhoneNo);
  try {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch $url');
    }
  } catch (e) {
    print('Phone call failed: $e');
  }
}

Future<void> callHelpline() async {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'android.intent.action.DIAL',
      data: 'tel:9229258016',
    );

    try {
      await intent.launch();
    } catch (e) {
      print("Failed to launch dialer: $e");
    }
  } else {
    print("Not supported on this platform.");
  }
}

String formatdate(String unformatted) {
  String formatted = unformatted.split(' ')[0];
  DateTime date = DateTime.parse(formatted);
  String finaldate = DateFormat('d MMMM y').format(date);
  return finaldate;
}
