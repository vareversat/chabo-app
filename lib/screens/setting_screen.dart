import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:chabo_app/bloc/forecast/forecast_bloc.dart';
import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/helpers/custom_page_routes.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/enums/theme_state_status.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/screens/about_screen/about_screen.dart';
import 'package:chabo_app/widgets/chabo_app_bar/chabo_app_bar.dart';
import 'package:chabo_app/widgets/simple_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting-screen';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: ChaboAppBar(
        displayStatus: false,
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.of(context).push(
                LeftToRightPageRoute(
                  builder: (context) => AboutScreen(),
                  settings: const RouteSettings(name: AboutScreen.routeName),
                ),
              ),
            },
            icon: Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20,
          children: [
            SimpleContainer(
              child: Column(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.palette),
                    title: Text(
                      AppLocalizations.of(context)!.themeSettingTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.themeSettingSubTitle,
                    ),
                  ),
                  BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      return Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: 15,
                        children: [
                          AnimatedToggleSwitch<ThemeStateStatus>.size(
                            indicatorSize: const Size.fromWidth(80),
                            current: state.status,
                            values: const [
                              ThemeStateStatus.light,
                              ThemeStateStatus.dark,
                              ThemeStateStatus.system,
                            ],
                            iconBuilder: (value) {
                              return Icon(
                                size: 20,
                                value.icon,
                                color: state.status == value
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface,
                              );
                            },
                            onChanged: (value) => BlocProvider.of<ThemeBloc>(
                              context,
                            ).add(ThemeChanged(status: value)),
                          ),
                          AnimatedSwitcher(
                            duration: const Duration(
                              milliseconds:
                                  CustomProperties.shortAnimationDurationMs,
                            ),
                            reverseDuration: const Duration(
                              milliseconds:
                                  CustomProperties.shortAnimationDurationMs,
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
                              key: ValueKey<String>(state.status.text(context)),
                              state.status.text(context),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            SimpleContainer(
              child: Column(
                children: [
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.clock),
                    title: Text(
                      AppLocalizations.of(context)!.timeFormatTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context)!.timeFormatSubTitle,
                    ),
                  ),
                  BlocBuilder<TimeFormatCubit, TimeFormatState>(
                    builder: (context, state) {
                      return Wrap(
                        children: [
                          AnimatedToggleSwitch<TimeFormat>.size(
                            current: state.timeFormat,
                            values: const [
                              TimeFormat.twelveHours,
                              TimeFormat.twentyFourHours,
                            ],
                            borderWidth: 1.5,
                            indicatorSize: const Size.fromWidth(100),
                            iconBuilder: (value) {
                              return Text(
                                value.text,
                                style: TextStyle(
                                  color: state.timeFormat == value
                                      ? colorScheme.onPrimary
                                      : colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            onChanged: (value) =>
                                context.read<TimeFormatCubit>().setTimeFormat(),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<ForecastBloc, ForecastState>(
                    builder: (context, state) {
                      final lastRefresh = state.lastRefresh;
                      if (lastRefresh == null) {
                        return const SizedBox.shrink();
                      }
                      final languageCode = Localizations.localeOf(
                        context,
                      ).languageCode;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          '${AppLocalizations.of(context)!.lastRefreshLabel}: '
                          '${DateFormat.yMd(languageCode).add_Hm().format(lastRefresh)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
