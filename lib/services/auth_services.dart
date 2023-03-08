import 'dart:convert';
import 'dart:io';

import 'package:complaints/constants.dart';
import 'package:complaints/helpers.dart';
import 'package:complaints/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category_model.dart';
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

      // save user token

      if (userInfo.token != null) {
        prefs.setString('token', 'Bearer ${userInfo.token}');
      }

      return ResponseModel(data: userInfo, message: 'success');
    } else {
      return ResponseModel(message: 'invalid');
    }
  }

  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/logout");
    var response =
        await http.post(url, headers: {HttpHeaders.authorizationHeader: token});
    if (response.statusCode == 200) {
      return true;
    } else {
      return true;
    }
  }

  static Future<CategoriesModel?> getAllCategories() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/categories");
    var response =
       await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      CategoriesModel categories = CategoriesModel.fromJson(jsonResponse);
      print("All Categories are : ------ ${categories.categories!.first.id}");
      return categories;
    }else{
      print("There is an error");
    }
  }

  static Future<bool> addCategory({required String name , required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/categories");
    var response =
    await http.post(url, headers: {HttpHeaders.authorizationHeader: token},body: {'name' : name});
    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      CategoriesModel categories = CategoriesModel.fromJson(jsonResponse);
      showSnackBar(context: context);
      return true;
    }else{
      showSnackBar(context: context,color: Colors.redAccent,message: "Failed to create an category");
      return false;
      print("There is an error");
    }
  }
}
