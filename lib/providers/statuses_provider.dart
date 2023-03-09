import 'package:flutter/material.dart';

import '../models/all_statuses.dart';
import '../services/get_all_statuses.dart';

class StatusesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Status>? _statuses;
  List<Status>? get statuses => _statuses;

  void getStatuses() {
    isLoading = true;
    notifyListeners();

    GetAllStatus.getAllStatuses().then((value) {
      _statuses = value.data.statuses;
    });
    isLoading = false;
    notifyListeners();
  }
}
