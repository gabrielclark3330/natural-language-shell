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
  final TextEditingController inputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Row(
        children: [
          const Icon(Icons.chevron_right_sharp, size: 32),
          Expanded(
              child: TextField(
            style: const TextStyle(
              fontSize: 20,
            ),
            controller: inputController,
            onSubmitted: (value) {
              // Sends the current value of text field to either output, history or a function.
              var term = Provider.of<TerminalModel>(context, listen: false);
              term.addCommand(value);
              inputController.text = "";
              var text = Provider.of<InputModel>(context, listen: false);
              text.change("");
              // print(value);
            },
            onChanged: (value) {
              // Keeps an updated value of the text field availble for when the submit button is pressed.
              var text = Provider.of<InputModel>(context, listen: false);
              text.change(value);
            },
            decoration: const InputDecoration(
              hintText: "helpme",
            ),
          )),
        ],
      ),
    );
  }
}
