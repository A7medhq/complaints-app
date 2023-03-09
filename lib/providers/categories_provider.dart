import 'package:complaints/models/category_model.dart';
import 'package:complaints/services/category_services.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Categories>? _categories;
  List<Categories>? get categories => _categories;

  void getCategories() {
    isLoading = true;
    notifyListeners();

    CategoryServices.getAllCategories().then((value) {
      _categories = value.data.categories;
    });
    isLoading = false;
    notifyListeners();
  }
}
