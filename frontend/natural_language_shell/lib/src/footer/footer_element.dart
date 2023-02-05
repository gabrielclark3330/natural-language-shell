import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/input/input_field.dart';
import 'package:natural_language_shell/src/mic/mic_button.dart';
import 'package:natural_language_shell/src/submit/submit_button.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 4),
        ),
        color: Theme.of(context).canvasColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: const [
                  MicButton(),
                  Expanded(child: InputField()),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SubmitButton(),
            ),
          ),
        ],
      ),
    );
  }
}
