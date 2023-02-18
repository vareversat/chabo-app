import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            const Hero(tag: 'settingsButtonIcon', child: Icon(Icons.settings)),
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: const Center(
        child: Text('Work in progress...'),
      ),
    );
  }
}
