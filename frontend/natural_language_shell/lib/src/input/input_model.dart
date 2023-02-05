import 'package:flutter/material.dart';

class InputModel extends ChangeNotifier {
  String _field = "";

  String get field => _field;

  void change(String str) {
    _field = str;
  }
}
