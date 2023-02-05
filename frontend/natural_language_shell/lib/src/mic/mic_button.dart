import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/input/input_model.dart';
import 'package:provider/provider.dart';
import 'dart:ffi' as ffi;
import 'dart:io' show Directory, Platform, sleep;
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// This is the type of the c++ function that dart is interacting with
typedef whisper_core_loop = ffi.Pointer<Utf8> Function(
    ffi.Int, ffi.Pointer<ffi.Pointer<Utf8>>);
// This is the type of the dart function dart uses
typedef WhisperLoop = ffi.Pointer<Utf8> Function(
    int, ffi.Pointer<ffi.Pointer<Utf8>>);

class MicButton extends StatefulWidget {
  const MicButton({super.key});

  @override
  State<MicButton> createState() => _MicButton();
}

class CommandLineArgs {
  final RegExp argsSplit =
      RegExp(r'([-a-zA-Z0-9]+)|(".*?[^\\]")|("")|([/._\-a-zA-Z0-9]+)');
  late final List<ffi.Pointer<Utf8>> _args;
  late final ffi.Pointer<ffi.Pointer<Utf8>> argv;
  late final int argc;

  CommandLineArgs(String argString) {
    final argsList = argsSplit.allMatches(argString);
    argc = argsList.length;
    _args =
        argsList.map((s) => s.group(0)!.toNativeUtf8().cast<Utf8>()).toList();
    argv = malloc.allocate(ffi.sizeOf<ffi.Pointer<Utf8>>() * argc);
    for (int i = 0; i < argc; i++) {
      argv[i] = _args[i];
    }
  }

  free() {
    malloc.free(argv);
    _args.forEach(malloc.free);
  }
}

/// placeholder for actually running the microphone
bool startMicFunction(BuildContext context) {
  var cppCode = path.absolute("cppCode/");
  var libraryPath = path.join(cppCode, 'whisper.cpp', 'libwhisper.so');
  if (Platform.isMacOS) {
    libraryPath = path.join(cppCode, 'whisper.cpp', 'libwhisper.dylib');
  } else if (Platform.isWindows) {
    libraryPath = path.join(cppCode, 'whisper.cpp', 'libwhisper.dll');
  }

  String whisperCodePath = path.join(cppCode, 'whisper.cpp', 'main');
  String whisperModelPath =
      path.join(cppCode, 'whisper.cpp', 'models', 'ggml-base.en.bin');
  String audioWavPath = path.join(cppCode, 'whisper.cpp', 'samples', 'jfk.wav');

  final dylib = ffi.DynamicLibrary.open(libraryPath);
  final WhisperLoop translate = dylib
      .lookup<ffi.NativeFunction<whisper_core_loop>>('core_loop')
      .asFunction();
  /*-m models/ggml-base.en.bin*/ // installed with the command "bash ./models/download-ggml-model.sh base.en"
  var cmdArgs = CommandLineArgs(
      whisperCodePath + " -m " + whisperModelPath + " -f " + audioWavPath);

  //speech_text =
  translate(cmdArgs.argc, cmdArgs.argv).toDartString();
  cmdArgs.free();

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
