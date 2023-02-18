import 'package:chabo/dialogs/carg_about_dialog.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [ListTile(
            key: const ValueKey('aboutButton'),
            subtitle: Text(
                AppLocalizations.of(context)!.informationAboutTheApp,
                style: const TextStyle(fontSize: 15)),
            selected: true,
            leading: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            onTap: () async => await showGeneralDialog(
                transitionDuration: const Duration(milliseconds: 300),
                context: context,
                pageBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return CargAboutDialog();
                }),
            title: Text(
              AppLocalizations.of(context)!.about,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 25),
            ),
          ),],
        ),
      ),
    );
  }
}
