import 'dart:convert';

class JsonHelper {
  static Map<String, dynamic>? parseJson(String json) {
    try {
      Map<String, dynamic> parsed = jsonDecode(json);
      return parsed;
    } catch (_){
      return null;
    }
  }
}