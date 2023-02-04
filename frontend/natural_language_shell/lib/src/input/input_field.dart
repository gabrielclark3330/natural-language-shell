import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class InputField extends StatelessWidget {
  const InputField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "helpme",
        ),
      ),
    );
  }
}
