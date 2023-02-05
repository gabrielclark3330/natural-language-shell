import 'dart:collection';

import 'package:flutter/material.dart';

class TerminalModel extends ChangeNotifier {
  final List<String> _commandHistory = [];
  final List<String> _commandToRun = [];
  // final List<String> _commandResponses = [];

  UnmodifiableListView<String> get history =>
      UnmodifiableListView(_commandHistory);
  // UnmodifiableListView<String> get responses =>
  //     UnmodifiableListView(_commandResponses);

  int get commandCount => _commandHistory.length;
  UnmodifiableListView<String> get commandToRun =>
      UnmodifiableListView(_commandToRun);
  // int get responseCount => _commandResponses.length;

  void addCommand(String str) {
    _commandHistory.add(str);
    notifyListeners();

    while (_commandHistory.length > 25) {
      _commandHistory.removeAt(0);
    }

    notifyListeners();
  }

  void setCommand(String str) {
    _commandToRun.add(str);
    notifyListeners();
  }

  // void addResponse(String str) {
  //   _commandResponses.add(str);
  //   notifyListeners();
  // }
}
