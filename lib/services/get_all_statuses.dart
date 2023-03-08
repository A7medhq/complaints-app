import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/all_statuses.dart';
import '../models/all_tags.dart';

class GetAllStatus {
  Future<bool> GetAllStatusInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/statuses");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var getStatus = StatusModal.fromJson(jsonResponse);
      print(getStatus.statuses[0].name);

      return true;
    } else {

      return false;
    }
  }
}
