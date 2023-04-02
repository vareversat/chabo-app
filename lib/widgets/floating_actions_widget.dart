import 'dart:ui';

import 'package:chabo/bloc/floating_actions_cubit.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/chabo_about_dialog.dart';
import 'package:chabo/screens/notification_screen.dart';
import 'package:chabo/widgets/theme_switcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FloatingActions extends StatefulWidget {
  const FloatingActions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FloatingActionsState();
  }
}

class _FloatingActionsState extends State<FloatingActions>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloatingActionsCubit, bool>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedSwitcher(
              duration: const Duration(
                milliseconds: 200,
              ),
              reverseDuration: const Duration(
                milliseconds: 200,
              ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity:
                      CurvedAnimation(parent: animation, curve: Curves.easeIn),
                  child: SlideTransition(
                    position: Tween(
                      begin: const Offset(0.0, 1.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: state
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: CustomProperties.blurSigmaX,
                        sigmaY: CustomProperties.blurSigmaY,
                      ),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        spacing: 10,
                        children: [
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              showModalBottomSheet(
                                useSafeArea: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (context) {
                                  return const TheSwitcherWidget();
                                },
                              );
                              context
                                  .read<FloatingActionsCubit>()
                                  .openActions();
                            },
                            label: Wrap(
                              spacing: 10,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.themeSetting,
                                ),
                                const Icon(Icons.format_paint_rounded),
                              ],
                            ),
                          ),
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () async {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          const NotificationScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(0.0, 1.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    var tween =
                                        Tween(begin: begin, end: end).chain(
                                      CurveTween(
                                        curve: curve,
                                      ),
                                    );

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                ),
                              );
                              context
                                  .read<FloatingActionsCubit>()
                                  .openActions();
                            },
                            label: Wrap(
                              spacing: 10,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .notificationsTitle,
                                ),
                                const Icon(
                                  Icons.notifications_active_outlined,
                                ),
                              ],
                            ),
                          ),
                          FloatingActionButton.extended(
                            heroTag: null,
                            onPressed: () {
                              showDialog(
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
                              );
                              context
                                  .read<FloatingActionsCubit>()
                                  .openActions();
                            },
                            label: Wrap(
                              spacing: 10,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.about,
                                ),
                                const Icon(
                                  Icons.info_outline,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 25,
            ),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                HapticFeedback.lightImpact();
                context.read<FloatingActionsCubit>().openActions();
              },
              label: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(
                      milliseconds: 200,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: 200,
                      ),
                      reverseDuration: const Duration(
                        milliseconds: 200,
                      ),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween(
                            begin: const Offset(0.5, 0.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(animation),
                          child: FadeTransition(
                              opacity: CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeIn,
                              ),
                              child: child),
                        );
                      },
                      child: state
                          ? Text(
                              AppLocalizations.of(context)!.settingsTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.start,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  state
                      ? const Icon(
                          Icons.close,
                        )
                      : const Icon(
                          Icons.settings,
                        ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
