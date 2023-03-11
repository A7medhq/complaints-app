import 'package:flutter/material.dart';

import '../models/all_statuses.dart';
import '../services/status_services.dart';

enum StatusesState { Initial, Loading, Loaded, Error }

class StatusesProvider extends ChangeNotifier {
  StatusesState _state = StatusesState.Initial;
  StatusesState get state => _state;

  List<Status>? _statuses;
  List<Status>? get statuses => _statuses;

  void getStatuses() async {
    _state = StatusesState.Loading;

    try {
      final res = await GetAllStatus.getAllStatuses();
      _statuses = res.data.statuses;
      _state = StatusesState.Loaded;
    } catch (e) {
      _state = StatusesState.Error;
    }
    notifyListeners();
  }
}
