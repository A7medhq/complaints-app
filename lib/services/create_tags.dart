import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/all_tags.dart';
Future<bool> createTags(String name) async {
  final prefs = await SharedPreferences.getInstance();

  String token = '';
  if (prefs.getString('token') != null) {
    token = prefs.getString('token')!;
  }

  var url = Uri.parse("$base_url/tags");
  var response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: token,
  });
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    var getTags = TagsModel.fromJson(jsonResponse);
   // print(ta);
    print('Name added successfully');

    return true;
  } else {
    print('Failed to add name');
    return false;
  }
}
