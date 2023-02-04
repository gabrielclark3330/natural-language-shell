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
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: const [
              MicButton(),
              InputField(),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomRight,
          child: SubmitButton(),
        ),
      ],
    );
  }
}
