import 'dart:collection';

import 'package:flutter/material.dart';

class TerminalModel extends ChangeNotifier {
  final List<String> _commandHistory = [];
  final List<String> _commandResponses = [];

  UnmodifiableListView<String> get history =>
      UnmodifiableListView(_commandHistory);
  UnmodifiableListView<String> get responses =>
      UnmodifiableListView(_commandResponses);

  int get commandCount => _commandHistory.length;
  int get responseCount => _commandResponses.length;

  void addCommand(String str) {
    _commandHistory.add(str);
    notifyListeners();
    addResponse("Ryans");
  }

  void addResponse(String str) {
    _commandResponses.add(str);
    notifyListeners();
  }
}
