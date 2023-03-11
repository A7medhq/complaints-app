import 'package:complaints/models/all_mails.dart';
import 'package:complaints/services/mail_services.dart';
import 'package:flutter/material.dart';

enum MailsState { Initial, Loading, Loaded, Error }

class MailsProvider extends ChangeNotifier {
  MailsState _state = MailsState.Initial;

  MailsState get state => _state;

  List<Mail>? _allMails;
  List<Mail>? get allMails => _allMails;

  void getAllMails() async {
    _state = MailsState.Loading;
    try {
      final res = await MailServices.getAllMails();

      _allMails = res.data.mails;

      _state = MailsState.Loaded;
    } catch (e) {
      _state = MailsState.Error;
    }
    notifyListeners();
  }
}
