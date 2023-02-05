import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/history/output_struct.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:provider/provider.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryView();
}

class _HistoryView extends State<HistoryView> {
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TerminalModel>(
      builder: (context, term, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
        return ListView.builder(
          controller: _scrollController,
          itemCount: term.commandCount,
          scrollDirection: Axis.vertical,
          clipBehavior: Clip.none,
          padding: EdgeInsets.all(30),
          itemBuilder: (BuildContext context, int index) {
            return Wrap(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(),
                  child: Standard(index, term.history[index]),
                )
              ],
              spacing: 20,
              runSpacing: 20,
            );
          },
        );
      },
    );
  }
}
