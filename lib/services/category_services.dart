import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../helpers.dart';
import '../models/category_model.dart';

class CategoryServices {
  static Future<CategoryModel?> getAllCategories() async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/categories");
    var response =
        await http.get(url, headers: {HttpHeaders.authorizationHeader: token});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      CategoryModel categories = CategoryModel.fromJson(jsonResponse);
      print("All Categories are : ------ ${categories.categories!.first.id}");
      return categories;
    } else {
      print("There is an error");
    }
  }

  static Future<bool> addCategory(
      {required String name, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/categories");
    var response = await http.post(url,
        headers: {HttpHeaders.authorizationHeader: token},
        body: {'name': name});
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      CategoryModel categories = CategoryModel.fromJson(jsonResponse);
      showSnackBar(context: context, message: 'Category Created Successfully!');
      return true;
    } else {
      showSnackBar(
          context: context,
          color: Colors.redAccent,
          message: "Failed to create an category");
      return false;
      print("There is an error");
    }
  }

  static Future<CategoryModel?> getCategory(
      {required int id, required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/categories/$id");
    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      CategoryModel category = CategoryModel.fromJson(jsonResponse);
      showSnackBar(
          context: context,
          message:
              "Fetching an category successfully : ${category.categories}");
      return category;
    } else {
      showSnackBar(
          context: context,
          color: Colors.redAccent,
          message: "Failed to fetch an category");
      return null;
    }
  }

  static Future<CategoryModel?> updateCategory(
      {required int id,
      required String name,
      required BuildContext context}) async {
    final prefs = await SharedPreferences.getInstance();

    String token = '';
    if (prefs.getString('token') != null) {
      token = prefs.getString('token')!;
    }

    var url = Uri.parse("$base_url/categories/$id");
    var response = await http.put(
      url,
      body: {'name': name},
      headers: {HttpHeaders.authorizationHeader: token},
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      CategoryModel category = CategoryModel.fromJson(jsonResponse);
      showSnackBar(
          context: context,
          message:
              "Updating an category successfully : ${category.categories}");
      return category;
    } else {
      showSnackBar(
          context: context,
          color: Colors.redAccent,
          message: "Failed to update an category");
      return null;
    }
  }
}
