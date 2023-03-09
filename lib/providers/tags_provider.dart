import 'package:flutter/material.dart';

import '../models/all_tags.dart';
import '../services/get_all_tags_service.dart';

class TagsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Tag>? _tags;
  List<Tag>? get tags => _tags;

  void getTags() {
    isLoading = true;
    notifyListeners();

    TagsServices.getAllTags().then((value) {
      _tags = value.data.tags;
    });
    isLoading = false;
    notifyListeners();
  }
}
