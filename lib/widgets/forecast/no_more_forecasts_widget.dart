import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/boat_forecast.dart';
import 'package:chabo_app/models/maintenance_forecast.dart';
import 'package:flutter/material.dart';

class NoMoreForecastsWidget extends StatelessWidget {
  const NoMoreForecastsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.noMoreForecastsTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.noMoreForecastsMessage,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoatForecast.fake().getIconWidget(context, false, 40, true),
                const Text('    •    '),
                MaintenanceForecast.fake().getIconWidget(
                  context,
                  false,
                  40,
                  true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
