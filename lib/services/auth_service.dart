import 'dart:async';

class AuthService {
  static Future<Map<String, String>> getAuthHeaders() async {
    Map<String, String> headers = {};
    headers['X-API-KEY'] = '6c6429b2d6fde367596a9c6c69020393';
    headers['X-API-USER-ID'] = 'AzatID';
    headers['X-API-USER-KEY'] = 'AzatUserKey';

    return headers;
  }
}
