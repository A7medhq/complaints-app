import 'package:complaints/models/all_mails.dart';
import 'package:complaints/services/mail_services.dart';
import 'package:flutter/material.dart';

class MailsProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Mail>? _allMails;
  List<Mail>? get allMails => _allMails;

  void getAllMails() {
    isLoading = true;
    notifyListeners();

    MailServices.getAllMails().then((value) {
      _allMails = value.data.mails.data;
    });
    isLoading = false;
    notifyListeners();
  }
}
