import 'package:flutter/material.dart';

class InputModel extends ChangeNotifier {
  // String _field = "";
  final TextEditingController inputController = TextEditingController();

  // String get field => _field;

  String get text => inputController.text;
  TextEditingController get controller => inputController;

  void clear() {
    inputController.text = "";
  }

  void set(String text) {
    inputController.text = text;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  // void change(String str) {
  //   _field = str;
  // }
}
