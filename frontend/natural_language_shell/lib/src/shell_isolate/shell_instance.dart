import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:isolate';

/*
class ShellInstance {
  static void printCallback(String chars) {
    print(chars);
  }

  ShellInstance() {

  }

  /// Execute a Hashcat command
  ///
  /// This will run on a separate core/thread using Dart [Isolate]s so it does not block the main thread
  Future<int> execute(String command,
      {void Function(String) callback = printCallback}) async {
    // Create a port to allow communication with the Isolate
    final ReceivePort port = ReceivePort();

    Completer c1 = Completer();
    int result = -1;
    port.listen((message) {
      if (message is String) {
        callback(message);
      } else if (message is int) {
        result = message;
        port.close();
      }
    }, onDone: () => c1.complete());

    final isolate =
        await Isolate.spawn<>();

    // This will wait until Hashcat is done
    await c1.future;
    // Close the thread
    isolate.kill(priority: Isolate.immediate);

    return result;
  }
}
*/