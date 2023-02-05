import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/input/input_model.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  minimumSize: const Size(10, 10),
  backgroundColor: Colors.grey,
  padding: const EdgeInsets.all(0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0),
  ),
);

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    // uses inputmodel for getting text in field
    return Consumer<InputModel>(
      builder: (context, textField, child) {
        return SizedBox(
          height: 100.0,
          width: 200.0,
          child: TextButton(
            style: flatButtonStyle,
            onPressed: () {
              if (textField.field.isNotEmpty) {
                // send only if there is something to send
                var text = Provider.of<TerminalModel>(context, listen: false);
                text.addCommand(textField.field);
              }
            },
            child: const Icon(Icons.keyboard_return_sharp, size: 48),
          ),
        );
      },
    );
  }
}
