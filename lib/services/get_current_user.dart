import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:complaints/models/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/categories_provider.dart';
import '../providers/mails_provider.dart';
import '../providers/statuses_provider.dart';
import '../providers/tags_provider.dart';

class CurrentUserService {
  static Future<bool> getCurrentUserInfo(BuildContext context) async {
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
      Provider.of<TagsProvider>(context, listen: false).getTags();
      Provider.of<StatusesProvider>(context, listen: false).getStatuses();
      Provider.of<CategoriesProvider>(context, listen: false).getCategories();
      Provider.of<MailsProvider>(context, listen: false).getAllMails();
      return true;
    } else {
      return false;
    }
  }
}
