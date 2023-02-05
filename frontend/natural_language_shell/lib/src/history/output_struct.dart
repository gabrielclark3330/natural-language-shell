import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:http/http.dart' as http;
import 'dart:ffi' as ffi;
import 'dart:io' show Directory, HttpClientRequest, Platform, sleep;
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart';
import 'package:provider/provider.dart';

typedef shell_command_runner = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);
typedef ShellCommandRunner = ffi.Pointer<Utf8> Function(ffi.Pointer<Utf8>);

class OpenAI {
  final String output;
  final String model;

  const OpenAI({required this.output, required this.model});

  OpenAI.fromJson(Map<String, dynamic> json)
      : output = json['choices'][0]['text'],
        model = json['model'];
}

class Standard extends StatefulWidget {
  final int index;
  final String query;

  const Standard(this.index, this.query, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Standard> createState() => _Standard(index);
}

class _Standard extends State<Standard> {
  late Future<String> _data;
  final int index;
  // final String query;
  _Standard(this.index);

  @override
  void initState() {
    super.initState();
    _data = getResponse();
  }

  Future<http.Response> send(String command, String key) {
    return http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $key',
      },
      body: jsonEncode(<String, dynamic>{
        "model": "text-davinci-003",
        "prompt":
            "// Translate the following newline separated instructions into bash commands. Only output bash commands without additional text. \n $command",
        "max_tokens": 1024
      }),
    );
  }

  Future<String> getResponse() async {
    var temp = Provider.of<TerminalModel>(context, listen: false);
    final String response =
        await rootBundle.loadString('assets/keys/secret.json');
    final data = await json.decode(response);
    var res = await send(temp.history[index], data['key']);
    OpenAI oai = OpenAI.fromJson(jsonDecode(res.body));

    // var cppCode = path.absolute("cppCode/");
    // var libraryPath = path.join(cppCode, 'shellApi', 'libshell_api_library.so');
    // if (Platform.isMacOS) {
    //   libraryPath =
    //       path.join(cppCode, 'shellApi', 'libshell_api_library.dylib');
    // } else if (Platform.isWindows) {
    //   libraryPath = path.join(cppCode, 'shellApi', 'libshell_api_library.dll');
    // }

    // // String whisperCodePath = path.join(cppCode, 'whisperCpp', 'main');

    // final dylib = ffi.DynamicLibrary.open(libraryPath);
    // final ShellCommandRunner exec = dylib
    //     .lookup<ffi.NativeFunction<shell_command_runner>>('exec')
    //     .asFunction();

    // String programOutput =
    //     exec(temp.history[index].toNativeUtf8()).toDartString();
    // print(programOutput);

    print(jsonDecode(res.body));
    return Future.delayed(const Duration(seconds: 4), () {
      return oai.output.trim();

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
          child: IntrinsicHeight(
            child: Consumer<TerminalModel>(builder: (context, term, child) {
              return Text("> ${term.history[index]}");
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 4,
          ),
          child: IntrinsicHeight(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text("< ${snapshot.data}");
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
