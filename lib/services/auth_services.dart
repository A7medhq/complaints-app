import 'dart:convert';

import 'package:complaints/constants.dart';
import 'package:complaints/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response_model.dart';

class AuthServices {
  Future<ResponseModel> login(
      {required String password, required String email}) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse("$base_url/login");
    var response =
        await http.post(url, body: {'email': email, 'password': password});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var userInfo = UserModel.fromJson(jsonResponse);
      prefs.setString('user', response.body);
      return ResponseModel(userModel: userInfo, message: 'success');
    } else {
      return ResponseModel(message: 'invalid');
    }
  }
}
