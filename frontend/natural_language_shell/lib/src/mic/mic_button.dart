import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class MicButton extends StatefulWidget {
  const MicButton({super.key});

  @override
  State<MicButton> createState() => _MicButton();
}

/// placeholder for actually running the microphone
bool startMicFunction() {
  return true;
}

class _MicButton extends State<MicButton> {
  bool isOff = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 48,
      enableFeedback: true,
      icon: (isOff)
          ? const Icon(
              Icons.mic_off_sharp,
              color: Colors.red,
            )
          : const Icon(
              Icons.mic,
              color: Colors.blue,
            ),
      onPressed: () {
        // basic logic for only showing mic on if the mic completes a check and actually turns on.
        if (isOff) {
          bool micStart = startMicFunction();
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
