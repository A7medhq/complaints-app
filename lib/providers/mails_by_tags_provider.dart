import 'package:flutter/material.dart';

import '../models/AllMailsOfTags.dart';
import '../services/tag_services.dart';

enum MailsByTagsState { Initial, Loading, Loaded, Error }

class MailsByTagsProvider extends ChangeNotifier {
  MailsByTagsState _state = MailsByTagsState.Initial;
  MailsByTagsState get state => _state;

  List<Mail>? _mails;
  List<Mail>? get mails => _mails;

  void getTags({required List<int> tags}) async {
    _state = MailsByTagsState.Loading;

    try {
      final res = await TagsServices.getAllMailsOfTags(tags: tags);

      _mails = res.data.first.mails;

      _state = MailsByTagsState.Loaded;
    } catch (e) {
      _state = MailsByTagsState.Error;
    }
    notifyListeners();
  }
}
