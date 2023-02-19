import 'package:chabo/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemePickerDialog extends StatelessWidget {
  const ThemePickerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.brightTheme,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      turns: state.status == ThemeStateStatus.bright ? 1 : 0,
                      child: Icon(
                        Icons.brightness_low,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                value: ThemeStateStatus.bright,
                groupValue: state.status,
                onChanged: (ThemeStateStatus? value) {
                  if (value != null) {
                    BlocProvider.of<ThemeBloc>(context).add(
                      ThemeChanged(status: value),
                    );
                  }
                },
              ),
              RadioListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.darkTheme,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      turns: state.status == ThemeStateStatus.bright ? 0 : 1,
                      child: Icon(
                        Icons.dark_mode_outlined,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                value: ThemeStateStatus.dark,
                groupValue: state.status,
                onChanged: (ThemeStateStatus? value) {
                  if (value != null) {
                    BlocProvider.of<ThemeBloc>(context).add(
                      ThemeChanged(status: value),
                    );
                  }
                },
              ),
              RadioListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.systemTheme,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.settings,
                    ),
                  ],
                ),
                value: ThemeStateStatus.system,
                groupValue: state.status,
                onChanged: (ThemeStateStatus? value) {
                  if (value != null) {
                    BlocProvider.of<ThemeBloc>(context).add(
                      ThemeChanged(
                        status: value,
                      ),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
