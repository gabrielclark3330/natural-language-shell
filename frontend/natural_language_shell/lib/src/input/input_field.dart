import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/input/input_model.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputField();
}

class _InputField extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Row(
        children: [
          const Icon(Icons.chevron_right_sharp, size: 32),
          Expanded(
              child: Consumer<InputModel>(builder: (context, textField, child) {
            return TextField(
              focusNode: textField.focus,
              autofocus: true,
              style: const TextStyle(
                fontSize: 20,
              ),
              controller: textField.controller,
              onSubmitted: (value) {
                // Sends the current value of text field to either output, history or a function.
                var term = Provider.of<TerminalModel>(context, listen: false);
                term.addCommand(value);
                var text = Provider.of<InputModel>(context, listen: false);
                text.set("");
                FocusScope.of(context).requestFocus(textField.focus);
              },
              decoration: const InputDecoration(
                hintText: "List the contents of the home directory...",
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
              ),
            );
          })),
        ],
      ),
    );
  }
}
