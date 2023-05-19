import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:chabo/bloc/theme/theme_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/enums/theme_state_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeSwitcherWidget extends StatelessWidget {
  const ThemeSwitcherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            spacing: 15,
            children: [
              Text(
                AppLocalizations.of(context)!.themeSettingSubtitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedToggleSwitch<ThemeStateStatus>.size(
                current: state.status,
                values: const [
                  ThemeStateStatus.light,
                  ThemeStateStatus.dark,
                  ThemeStateStatus.system,
                ],
                indicatorColor: colorScheme.tertiary,
                innerColor: colorScheme.primaryContainer,
                borderColor: colorScheme.primary,
                indicatorSize: const Size.fromWidth(65),
                iconBuilder: (value, size) {
                  return Icon(
                    value.icon,
                    color: state.status == value
                        ? colorScheme.onTertiary
                        : colorScheme.onPrimaryContainer,
                  );
                },
                onChanged: (value) => BlocProvider.of<ThemeBloc>(context).add(
                  ThemeChanged(
                    status: value,
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: CustomProperties.shortAnimationDurationMs,
                ),
                reverseDuration: const Duration(
                  milliseconds: CustomProperties.shortAnimationDurationMs,
                ),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(0.0, 1.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeIn,
                      ),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  key: ValueKey<String>(
                    state.status.text(context),
                  ),
                  state.status.text(context),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
