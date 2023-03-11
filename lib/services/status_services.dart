import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:complaints/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/all_statuses.dart';

class GetAllStatus {
  static Future<ResponseModel> getAllStatuses() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/statuses?mail=true");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var getStatus = StatusModal.fromJson(jsonResponse);

      return ResponseModel(data: getStatus, message: 'success');
    } else {
      return ResponseModel(message: 'failed');
    }
  }
}
