import 'dart:ui';

import 'package:chabo/cubits/floating_actions_cubit.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/dialogs/chabo_about_dialog.dart';
import 'package:chabo/helpers/custom_page_routes.dart';
import 'package:chabo/screens/notification_screen/notification_screen.dart';
import 'package:chabo/widgets/floating_actions/floating_actions_item.dart';
import 'package:chabo/widgets/theme_switcher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FloatingActionsWidget extends StatefulWidget {
  const FloatingActionsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FloatingActionsWidgetState();
  }
}

class _FloatingActionsWidgetState extends State<FloatingActionsWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FloatingActionsCubit, FloatingActionsState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: state.isRightHanded
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(
                milliseconds: CustomProperties.shortAnimationDurationMs,
              ),
              reverseDuration: const Duration(
                milliseconds: CustomProperties.shortAnimationDurationMs,
              ),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeIn,
                  ),
                  child: SlideTransition(
                    position: Tween(
                      begin: const Offset(0.0, 1.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: state.isMenuOpen
                  ? BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: CustomProperties.blurSigmaX,
                        sigmaY: CustomProperties.blurSigmaY,
                      ),
                      child: Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: state.isRightHanded
                            ? WrapCrossAlignment.end
                            : WrapCrossAlignment.start,
                        spacing: 10,
                        children: [
                          FloatingActionsItem(
                            onPressed: () {
                              context
                                  .read<FloatingActionsCubit>()
                                  .changeFloatingActionsSide();
                            },
                            content: [
                              Text(
                                state.isRightHanded
                                    ? AppLocalizations.of(context)!.rightHanded
                                    : AppLocalizations.of(context)!.leftHanded,
                              ),
                              Icon(state.isRightHanded
                                  ? Icons.back_hand
                                  : Icons.front_hand),
                            ],
                            isRightHanded: state.isRightHanded,
                            isSpaced: true,
                          ),
                          FloatingActionsItem(
                            onPressed: () {
                              showModalBottomSheet(
                                useSafeArea: true,
                                constraints: const BoxConstraints(
                                  minWidth: double.infinity,
                                ),
                                enableDrag: false,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                      CustomProperties.borderRadius * 2,
                                    ),
                                  ),
                                ),
                                builder: (context) {
                                  return const ThemeSwitcherWidget();
                                },
                              );
                              context
                                  .read<FloatingActionsCubit>()
                                  .openFloatingActions();
                            },
                            content: [
                              Text(AppLocalizations.of(context)!.themeSetting),
                              const Icon(
                                Icons.format_paint_rounded,
                              ),
                            ],
                            isRightHanded: state.isRightHanded,
                            isSpaced: true,
                          ),
                          FloatingActionsItem(
                            onPressed: () {
                              Navigator.of(context).push(
                                BottomToTopPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen(
                                    highlightTimeSlots: false,
                                  ),
                                ),
                              );
                              context
                                  .read<FloatingActionsCubit>()
                                  .openFloatingActions();
                            },
                            content: [
                              Text(
                                AppLocalizations.of(context)!
                                    .notificationsTitle,
                              ),
                              const Icon(
                                Icons.notifications_active_outlined,
                              ),
                            ],
                            isRightHanded: state.isRightHanded,
                            isSpaced: true,
                          ),
                          FloatingActionsItem(
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
                                  .openFloatingActions();
                            },
                            content: [
                              Text(
                                AppLocalizations.of(context)!.about,
                              ),
                              const Icon(
                                Icons.info_outline,
                              ),
                            ],
                            isRightHanded: state.isRightHanded,
                            isSpaced: true,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 25,
            ),
            FloatingActionsItem(
              onPressed: () {
                HapticFeedback.lightImpact();
                context.read<FloatingActionsCubit>().openFloatingActions();
              },
              isRightHanded: state.isRightHanded,
              content: [
                AnimatedSize(
                  curve: Curves.easeIn,
                  duration: const Duration(
                    milliseconds: CustomProperties.shortAnimationDurationMs,
                  ),
                  reverseDuration: const Duration(
                    milliseconds: 0,
                  ),
                  child: state.isMenuOpen
                      ? Text(
                          AppLocalizations.of(context)!.settingsTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.start,
                        )
                      : const SizedBox.shrink(),
                ),
                state.isMenuOpen
                    ? const Icon(
                        Icons.close,
                      )
                    : const Icon(
                        Icons.settings,
                      ),
              ],
              isSpaced: state.isMenuOpen,
            ),
          ],
        );
      },
    );
  }
}
