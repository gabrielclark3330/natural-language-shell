import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';

import 'dart:ffi' as ffi;
import 'dart:io' show Directory, Platform, sleep;
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';
import 'package:provider/provider.dart';

typedef shell_command_runner = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);
typedef ShellCommandRunner = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);

class Standard extends StatefulWidget {
  final int index;
  final String query;

  const Standard(this.index, this.query, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Standard> createState() => _Standard(index, query);
}

class _Standard extends State<Standard> {
  late Future<String> _data;
  final int index;
  final String query;
  _Standard(this.index, this.query);

  @override
  void initState() {
    super.initState();
    _data = getResponse();
  }

  Future<String> getResponse() async {
    var temp = Provider.of<TerminalModel>(context, listen: false);

    var cppCode = path.absolute("cppCode/");
    var libraryPath = path.join(cppCode, 'shellApi', 'libshell_api_library.so');
    if (Platform.isMacOS) {
      libraryPath =
          path.join(cppCode, 'shellApi', 'libshell_api_library.dylib');
    } else if (Platform.isWindows) {
      libraryPath = path.join(cppCode, 'shellApi', 'libshell_api_library.dll');
    }

    String whisperCodePath = path.join(cppCode, 'whisper.cpp', 'main');

    final dylib = ffi.DynamicLibrary.open(libraryPath);
    final ShellCommandRunner exec = dylib
        .lookup<ffi.NativeFunction<shell_command_runner>>('exec')
        .asFunction();

    String programOutput =
        exec(temp.history[index].toNativeUtf8()).toDartString();
    print(programOutput);

    return Future.delayed(const Duration(seconds: 2), () {
      return programOutput;
      // throw Exception("Custom Error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 4,
          ),
          child: SizedBox(
            height: 20,
            child: Text("> $query"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 4,
          ),
          child: SizedBox(
            height: 20,
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("< ${snapshot.data} $index");
                } else {
                  return Row(
                    children: const [
                      Text("< "),
                      Icon(Icons.timer),
                    ],
                  );
                }
              },
              future: _data,
            ),
          ),
        ),
      ],
    );
  }
}
