import 'dart:math';

import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TerminalModel>(
      builder: (context, term, child) {
        return ListView.builder(
          itemCount: min(term.commandCount, 30),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
              child: Text("> ${term.history[index]}"),
            );
          },
        );
      },
    );
  }
}
