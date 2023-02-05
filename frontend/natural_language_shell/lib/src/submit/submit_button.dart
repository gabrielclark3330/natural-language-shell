import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/input/input_model.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    // uses inputmodel for getting text in field
    return Consumer<InputModel>(
      builder: (context, textField, child) {
        return IconButton(
          onPressed: () {
            if (textField.field.isNotEmpty) {
              // send only if there is something to send
              var text = Provider.of<TerminalModel>(context, listen: false);
              text.add(textField.field);
            }
          },
          icon: const Icon(Icons.keyboard_return_sharp),
        );
      },
    );
  }
}
