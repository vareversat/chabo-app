import 'package:chabo/custom_properties.dart';
import 'package:flutter/material.dart';

abstract class NotificationSettingsWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? iconData;
  final bool enabled;

  const NotificationSettingsWidget(
      {Key? key,
      this.iconData,
      this.subtitle,
      required this.title,
      required this.enabled})
      : super(key: key);

  void onEnablePressed(bool value, BuildContext context);

  void onEditPressed(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 28),
                  ),
                  subtitle != null
                      ? Text(
                          subtitle!,
                          style: const TextStyle(fontSize: 15),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            Column(
              children: [
                Switch(
                  value: enabled,
                  onChanged: (bool value) => onEnablePressed(value, context),
                ),
                iconData != null
                    ? IconButton(
                        onPressed: () => onEditPressed(context),
                        icon: AnimatedSwitcher(
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          duration: const Duration(
                            milliseconds: CustomProperties.animationDurationMs,
                          ),
                          child: Icon(
                            iconData,
                            size: 25,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
