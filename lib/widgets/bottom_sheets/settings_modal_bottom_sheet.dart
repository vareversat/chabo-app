import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/models/enums/theme_state_status.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsModalBottomSheet extends StatelessWidget {
  const SettingsModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        direction:
            DeviceHelper.isPortrait(context) || !DeviceHelper.isMobile(context)
                ? Axis.horizontal
                : Axis.vertical,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing:
            DeviceHelper.isPortrait(context) || !DeviceHelper.isMobile(context)
                ? 0
                : 35,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 15,
        children: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Wrap(
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
                    style: ToggleStyle(
                      backgroundColor: colorScheme.surface,
                      indicatorColor: colorScheme.primary,
                      borderColor: colorScheme.inverseSurface,
                    ),
                    borderWidth: 1.5,
                    indicatorSize: const Size.fromWidth(65),
                    iconBuilder: (value) {
                      return Icon(
                        value.icon,
                        color: state.status == value
                            ? colorScheme.onPrimary
                            : colorScheme.onSurface,
                      );
                    },
                    onChanged: (value) =>
                        BlocProvider.of<ThemeBloc>(context).add(
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
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
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
              );
            },
          ),
          DeviceHelper.isPortrait(context)
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Divider(),
                )
              : const SizedBox.shrink(),
          BlocBuilder<TimeFormatCubit, TimeFormatState>(
            builder: (context, state) {
              return Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                spacing: 15,
                children: [
                  AnimatedToggleSwitch<TimeFormat>.size(
                    current: state.timeFormat,
                    values: const [
                      TimeFormat.twelveHours,
                      TimeFormat.twentyFourHours,
                    ],
                    style: ToggleStyle(
                      backgroundColor: colorScheme.surface,
                      indicatorColor: colorScheme.primary,
                      borderColor: colorScheme.inverseSurface,
                    ),
                    borderWidth: 1.5,
                    indicatorSize: const Size.fromWidth(65),
                    iconBuilder: (value) {
                      return Text(
                        value.text,
                        style: TextStyle(
                            color: state.timeFormat == value
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                            fontWeight: FontWeight.bold),
                      );
                    },
                    onChanged: (value) =>
                        context.read<TimeFormatCubit>().setTimeFormat(),
                  ),
                  Text(
                    AppLocalizations.of(context)!.timeFormatSubTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
