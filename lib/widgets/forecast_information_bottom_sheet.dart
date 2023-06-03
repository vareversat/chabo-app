import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/helpers/custom_page_routes.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForecastInformationBottomSheet extends StatelessWidget {
  final AbstractForecast forecast;

  const ForecastInformationBottomSheet({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: forecast.getColor(context, false),
                  child: forecast.getIconWidget(context, true, 30, true),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 4,
                child: Container(
                  constraints: DeviceHelper.isMobile(context)
                      ? DeviceHelper.isPortrait(context)
                          ? null
                          : BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                            )
                      : BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5,
                        ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      forecast.getInformationWidget(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (forecast.interferingTimeSlots.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.warningColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!
                          .favoriteSlotsInterferenceWarning,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        colorScheme.warningColor,
                      ),
                    ),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      Navigator.of(context).push(
                        BottomToTopPageRoute(
                          builder: (context) => const NotificationScreen(
                            highlightTimeSlots: true,
                          ),
                        ),
                      ),
                    },
                    child: const Icon(
                      Icons.notifications_active,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
