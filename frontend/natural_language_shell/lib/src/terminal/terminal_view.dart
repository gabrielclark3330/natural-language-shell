import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/footer/footer_element.dart';
import 'package:natural_language_shell/src/history/history_view.dart';

import 'package:natural_language_shell/src/settings/settings_view.dart';

class TerminalView extends StatelessWidget {
  const TerminalView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Part that shows all the previous commands and the output of the command.
          SizedBox(
            height: MediaQuery.of(context).size.height - 176,
            child: const HistoryView(),
          ),
          // Input fields and related widgets.
          const Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 64,
                child: Footer(),
              ))
        ],
      ),
    );
  }
}
