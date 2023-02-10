import 'dart:async';
import 'package:flutter_chat/global_vars.dart';

class AuthService {
  static Future<Map<String, String>> getAuthHeaders() async {
    Map<String, String> headers = {};
    headers['X-API-KEY'] = apiKey;
    headers['X-API-USER-ID'] = 'd567b3ff-edbd-464f-8cb2-869a83ea6d2f';
    headers['X-API-USER-KEY'] =
        'ff52a8241959c3ce2b5bbf014a62dcf2838e92f9d0cea82138a9978315f2600e';

    return headers;
  }
}
