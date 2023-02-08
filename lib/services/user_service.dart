import 'dart:async';

import 'package:flutter_chat/models/company.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static Future<Company?> init(User user) async {
    Map<String, String> headers = await AuthService.getAuthHeaders();
    headers['Content-Type'] = 'application/json';

    final response = await http.post(
      Uri.parse("https://advantchat.ru/api/init.php"),
      headers: headers,
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (responseBody['status'].toString() == 'error') {
        return null;
      } else {
        return Company.fromJson(jsonDecode(response.body));
      }
    } else {
      throw Exception('Failed to init');
    }
  }
}
