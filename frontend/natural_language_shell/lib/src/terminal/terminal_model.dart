import 'dart:collection';

import 'package:flutter/material.dart';

class TerminalModel extends ChangeNotifier {
  final List<String> _history = [];

  UnmodifiableListView<String> get history => UnmodifiableListView(_history);

  int get commandCount => _history.length;

  void add(String str) {
    _history.add(str);
    notifyListeners();
  }
}
