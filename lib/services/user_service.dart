import 'dart:async';
import 'package:flutter_chat/global_vars.dart';
import 'package:flutter_chat/models/company.dart';
import 'package:flutter_chat/models/message.dart';
import 'package:flutter_chat/models/user.dart';
import 'package:flutter_chat/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  static Future<Company?> init(User user) async {
    Map<String, String> headers = await AuthService.getAuthHeaders();
    headers['Content-Type'] = 'application/json';

    final response = await http.post(
      Uri.parse("$apiHost/api/init.php"),
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

  static Future<List<Message>?> getMessages({int? beforeMEssageId}) async {
    Map<String, String> headers = await AuthService.getAuthHeaders();
    headers['Content-Type'] = 'application/json';
    String requestJson = '';

    if (beforeMEssageId != null) {
      requestJson = '{"beforeMEssageId": $beforeMEssageId}';
    }

    final response = await http.post(
      Uri.parse("$apiHost/api/chat.php"),
      headers: headers,
      body: jsonEncode(requestJson),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (responseBody['status'].toString() == 'error') {
        return null;
      } else {
        var list = jsonDecode(response.body) as List<dynamic>;

        return list
            .map((e) => Message.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } else {
      throw Exception('Failed to init');
    }
  }
}
