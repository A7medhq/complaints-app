import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:complaints/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/all_mails.dart';

class MailServices {
  static Future<ResponseModel> getAllMails() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/mails");
    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      AllMails allMails = AllMails.fromJson(jsonResponse);
      return ResponseModel(data: allMails, message: 'success');
    } else {
      return ResponseModel(message: 'failed');
    }
  }
}
