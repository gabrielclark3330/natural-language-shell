import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/input/input_model.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class MicButton extends StatefulWidget {
  const MicButton({super.key});

  @override
  State<MicButton> createState() => _MicButton();
}

/// placeholder for actually running the microphone
bool startMicFunction(BuildContext context) {
  var textField = Provider.of<InputModel>(context, listen: false);
  textField.set("INPUT FROM MICROPHONE");
  return true;
}

final ButtonStyle micButtonSytle = TextButton.styleFrom(
  minimumSize: const Size(10, 10),
  // backgroundColor: Colors.grey,
  // padding: const EdgeInsets.all(0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0),
  ),
);

const double iconSize = 64.0;

class _MicButton extends State<MicButton> {
  bool isOff = true;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: micButtonSytle,
      child: (isOff)
          ? const Icon(
              Icons.mic_off_sharp,
              size: iconSize,
              color: Colors.red,
            )
          : const Icon(
              Icons.mic,
              size: iconSize,
              color: Colors.blue,
            ),
      onPressed: () {
        // basic logic for only showing mic on if the mic completes a check and actually turns on.
        if (isOff) {
          bool micStart = startMicFunction(context);
          if (micStart) {
            setState(() {
              isOff = false;
            });
          } else {
            throw Exception("Mic no starty");
          }
        } else {
          setState(() {
            isOff = true;
          });
        }
      },
    );
  }
}
