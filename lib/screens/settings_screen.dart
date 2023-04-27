import 'dart:ui';

import 'package:chabo/bloc/theme/theme_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widgets_state.dart';
import 'package:chabo/dialogs/chabo_about_dialog.dart';
import 'package:chabo/dialogs/theme_picker_dialog.dart';
import 'package:chabo/models/enums/theme_state_status.dart';
import 'package:chabo/widgets/notification_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends CustomWidgetState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: const Icon(
          Icons.settings,
        ),
        title: Text(
          AppLocalizations.of(context)!.settingsTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 20,
        ),
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
                    duration: const Duration(
                        milliseconds: CustomProperties.animationDurationMs),
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
                      return BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: CustomProperties.blurSigmaX,
                            sigmaY: CustomProperties.blurSigmaY),
                        child: const ThemePickerDialog(),
                      );
                    },
                  ),
                );
              },
            ),
            const NotificationTileWidget(),
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
              onTap: () async => await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: CustomProperties.blurSigmaX,
                      sigmaY: CustomProperties.blurSigmaY,
                    ),
                    child: ChaboAboutDialog(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
