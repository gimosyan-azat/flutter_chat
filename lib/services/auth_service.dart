import 'dart:async';
import 'package:flutter_chat/global_vars.dart';

class AuthService {
  static Future<Map<String, String>> getAuthHeaders() async {
    Map<String, String> headers = {};
    headers['X-API-KEY'] = apiKey;
    headers['X-API-USER-ID'] = 'AzatID';
    headers['X-API-USER-KEY'] = 'AzatUserKey';

    return headers;
  }
}
