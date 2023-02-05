import 'package:flutter/material.dart';
import 'package:natural_language_shell/src/footer/footer_element.dart';
import 'package:natural_language_shell/src/history/history_view.dart';

import 'package:natural_language_shell/src/settings/settings_view.dart';
import 'package:natural_language_shell/src/terminal/terminal_model.dart';
import 'package:provider/provider.dart';

class TerminalView extends StatelessWidget {
  const TerminalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Natural Language Terminal'),
        actions: [
          Consumer<TerminalModel>(builder: (context, term, child) {
            return DropdownButton<int>(
                value: term.terminalSetting,
                // Call the updateThemeMode method any time the user selects a theme.
                onChanged: (mode) {
                  var term = Provider.of<TerminalModel>(context, listen: false);
                  term.setTerminalSetting(mode!);
                },
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Generate Command'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Explain Command'),
                  ),
                ]);
          }),
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
