import 'package:complaints/models/category_model.dart';
import 'package:complaints/services/category_services.dart';
import 'package:flutter/material.dart';

enum CategoriesState { Initial, Loading, Loaded, Error }

class CategoriesProvider extends ChangeNotifier {
  CategoriesState _state = CategoriesState.Initial;
  CategoriesState get state => _state;

  List<Categories>? _categories;
  List<Categories>? get categories => _categories;

  Future<void> getCategories() async {
    _state = CategoriesState.Loading;
    try {
      final res = await CategoryServices.getAllCategories();

      _categories = res.data.categories;

      _state = CategoriesState.Loaded;
    } catch (e) {
      _state = CategoriesState.Error;
    }
    notifyListeners();
  }
}
