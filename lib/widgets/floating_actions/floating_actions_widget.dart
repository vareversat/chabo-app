import 'dart:ui';

import 'package:chabo_app/cubits/floating_actions_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/helpers/custom_page_routes.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/screens/chabo_about_screen/chabo_about_screen.dart';
import 'package:chabo_app/screens/notification_screen/notification_screen.dart';
import 'package:chabo_app/widgets/ad_banner_widget.dart';
import 'package:chabo_app/widgets/bottom_sheets/settings_modal_bottom_sheet.dart';
import 'package:chabo_app/widgets/current_docked_boat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'floating_actions_item.dart';

class FloatingActionsWidget extends StatefulWidget {
  const FloatingActionsWidget({super.key});

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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Wrap(
                          direction: DeviceHelper.isMobile(context) &&
                                  !DeviceHelper.isPortrait(context)
                              ? Axis.horizontal
                              : Axis.vertical,
                          crossAxisAlignment: state.isRightHanded
                              ? WrapCrossAlignment.end
                              : WrapCrossAlignment.start,
                          spacing: 10,
                          children: [
                            _FloatingActionsItem(
                              onPressed: () {
                                context
                                    .read<FloatingActionsCubit>()
                                    .changeFloatingActionsSide();
                              },
                              content: [
                                Text(
                                  state.isRightHanded
                                      ? AppLocalizations.of(context)!
                                          .rightHanded
                                      : AppLocalizations.of(context)!
                                          .leftHanded,
                                ),
                                Icon(state.isRightHanded
                                    ? Icons.back_hand
                                    : Icons.front_hand),
                              ],
                              isRightHanded: state.isRightHanded,
                              isSpaced: true,
                            ),
                            _FloatingActionsItem(
                              onPressed: () {
                                showModalBottomSheet(
                                  useSafeArea: true,
                                  constraints: BoxConstraints(
                                    minWidth: DeviceHelper.isPortrait(context)
                                        ? double.infinity
                                        : MediaQuery.of(context).size.width / 3,
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
                                    return const SettingsModalBottomSheet();
                                  },
                                );
                                context
                                    .read<FloatingActionsCubit>()
                                    .openFloatingActions();
                              },
                              content: [
                                Text(
                                  AppLocalizations.of(context)!.openSetting,
                                ),
                                const Icon(
                                  Icons.settings,
                                ),
                              ],
                              isRightHanded: state.isRightHanded,
                              isSpaced: true,
                            ),
                            _FloatingActionsItem(
                              onPressed: () {
                                Navigator.of(context).push(
                                  BottomToTopPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen(),
                                    settings: const RouteSettings(
                                      name: NotificationScreen.routeName,
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
                            _FloatingActionsItem(
                              onPressed: () {
                                Navigator.of(context).push(
                                  BottomToTopPageRoute(
                                    builder: (context) => ChaboAboutScreen(),
                                    settings: const RouteSettings(
                                      name: ChaboAboutScreen.routeName,
                                    ),
                                  ),
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
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(
              height: 25,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  CustomProperties.borderRadius,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: CustomProperties.blurSigmaX,
                  sigmaY: CustomProperties.blurSigmaY,
                ),
                child: Padding(
                  padding: DeviceHelper.isPortrait(context)
                      ? const EdgeInsets.all(8)
                      : const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: state.isRightHanded
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: DeviceHelper.isPortrait(context)
                            ? MainAxisSize.max
                            : MainAxisSize.min,
                        mainAxisAlignment: state.isRightHanded
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: state.isRightHanded
                            ? _buildRow(state).reversed.toList()
                            : _buildRow(state),
                      ),
                      const AdBannerWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildRow(FloatingActionsState state) {
    return [
      _FloatingActionsItem(
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
                    AppLocalizations.of(context)!.settingsClose,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.start,
                  )
                : const SizedBox.shrink(),
          ),
          state.isMenuOpen
              ? const Icon(
                  Icons.expand_more,
                )
              : const Icon(
                  Icons.expand_less_outlined,
                ),
        ],
        isSpaced: state.isMenuOpen,
      ),
      const SizedBox(
        width: 10,
      ),
      const Flexible(
        child: CurrentDockedBoatButton(),
      ),
    ];
  }
}
