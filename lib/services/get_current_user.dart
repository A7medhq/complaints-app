import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:complaints/models/current_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CurrentUserService {
  static Future<bool> getCurrentUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/user");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var currentUser = CurrentUser.fromJson(jsonResponse);
      return true;
    } else {
      return false;
    }
  }
}
