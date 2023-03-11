import 'package:flutter/material.dart';

import '../models/all_tags.dart';
import '../services/tag_services.dart';

enum TagsState { Initial, Loading, Loaded, Error }

class TagsProvider extends ChangeNotifier {
  TagsState _state = TagsState.Initial;
  TagsState get state => _state;

  List<Tag>? _tags;
  List<Tag>? get tags => _tags;

  void getTags() async {
    _state = TagsState.Loading;

    try {
      final res = await TagsServices.getAllTags();
      _tags = res.data.tags;
      _state = TagsState.Loaded;
    } catch (e) {
      _state = TagsState.Error;
    }
    notifyListeners();
  }
}
