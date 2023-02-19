import 'package:chabo/bloc/theme_bloc.dart';
import 'package:chabo/dialogs/chabo_about_dialog.dart';
import 'package:chabo/dialogs/theme_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          children: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return ListTile(
                  key: const ValueKey('themeDialog'),
                  title: Text(
                    AppLocalizations.of(context)!.themeSetting,
                    style: const TextStyle(fontSize: 25),
                  ),
                  subtitle: Text(
                    AppLocalizations.of(context)!.themeSettingSubtitle,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  selected: true,
                  leading: AnimatedRotation(
                    duration: const Duration(milliseconds: 700),
                    turns: state.status == ThemeStateStatus.light ? 0 : 1,
                    child: Icon(
                      state.getIconData(),
                      size: 30,
                    ),
                  ),
                  onTap: () async => await showDialog(
                    context: context,
                    builder: (
                      BuildContext context,
                    ) {
                      return const ThemePickerDialog();
                    },
                  ),
                );
              },
            ),
            ListTile(
              key: const ValueKey('aboutButton'),
              title: Text(
                AppLocalizations.of(context)!.about,
                style: const TextStyle(fontSize: 25),
              ),
              subtitle: Text(
                AppLocalizations.of(context)!.informationAboutTheApp,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              selected: true,
              leading: const Icon(
                Icons.info_outline,
                size: 30,
              ),
              onTap: () async => await showGeneralDialog(
                transitionDuration: const Duration(milliseconds: 300),
                context: context,
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return ChaboAboutDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
