import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:complaints/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AllMailsOfTags.dart';
import '../models/all_tags.dart';
import '../models/create_tag.dart';

class TagsServices {
  static Future<ResponseModel> getAllTags() async {
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

      return ResponseModel(data: getTags, message: 'success');
    } else {
      return ResponseModel(message: 'failed');
    }
  }

  static Future<ResponseModel> getAllMailsOfTags(
      {required List<int> tags}) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/tags?tags=${tags.toString()}");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var allMails = AllMailsOfTags.fromJson(jsonResponse);

      return ResponseModel(data: allMails.tags, message: 'success');
    } else {
      return ResponseModel(message: 'failed');
    }
  }

  static Future<CreateTag?> createTags(String name) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/tags");
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: token,
    }, body: {
      'name': name
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      var tagCreated = CreateTag.fromJson(jsonResponse);

      return tagCreated;
    } else {
      print('Failed to add name');
      return null;
    }
  }
}
