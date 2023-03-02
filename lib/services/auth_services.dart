import 'dart:convert';

import 'package:complaints/constants.dart';
import 'package:complaints/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthServices {

  Future<dynamic> login({required String password, required String email}) async {
    var url = Uri.parse("$base_url/login");
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var userInfo = UserModel.fromJson(jsonResponse);
      return userInfo;
    } else if (response.statusCode == 401) {
      return false;
    }
    return false;
  }
}
