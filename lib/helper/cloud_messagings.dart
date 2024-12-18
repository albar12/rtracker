import 'package:firebase_messaging/firebase_messaging.dart';

class CloudMessagings {
  static Future<String?> token() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
