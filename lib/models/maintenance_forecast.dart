import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/extensions/duration_extension.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/models/enums/forecast_closing_reason.dart';
import 'package:chabo_app/models/enums/forecast_closing_type.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class MaintenanceForecast extends AbstractForecast {
  MaintenanceForecast({
    required bool totalClosing,
    required DateTime circulationClosingDate,
    required DateTime circulationReOpeningDate,
    required ForecastClosingType closingType,
  }) : super(
          circulationClosingDate: circulationClosingDate,
          circulationReOpeningDate: circulationReOpeningDate,
          closingReason: ForecastClosingReason.maintenance,
          closingType: closingType,
          totalClosing: totalClosing,
        );

  factory MaintenanceForecast.fromJSON(Map<String, dynamic> json) {
    var apiTimezone = AbstractForecast.getApiTimeZone(json['record_timestamp']);
    var closingDate = AbstractForecast.parseFieldDate(
      json,
      'fermeture_a_la_circulation',
      apiTimezone,
    );
    var reopeningDate = AbstractForecast.parseFieldDate(
      json,
      're_ouverture_a_la_circulation',
      apiTimezone,
    );
    var closingType =
        (json['fields']['type_de_fermeture'] as String).toLowerCase() ==
                'totale'
            ? ForecastClosingType.complete
            : ForecastClosingType.partial;
    var totalClosing = AbstractForecast.getBooleanTotalClosingValue(
      json['fields']['fermeture_totale'],
    );

    return MaintenanceForecast(
      totalClosing: totalClosing,
      circulationReOpeningDate: reopeningDate,
      circulationClosingDate: closingDate,
      closingType: closingType,
    );
  }

  @override
  List<Object?> get props => [
        totalClosing,
        closingReason,
        closedDuration,
        circulationClosingDate,
        circulationReOpeningDate,
        closingType,
      ];

  @override
  String getNotificationDurationMessage(
    BuildContext context,
    String pickedDuration,
  ) {
    return AppLocalizations.of(context)!.notificationDurationMaintenanceMessage(
      pickedDuration,
      closedDuration.durationToString(context),
    );
  }

  @override
  String getNotificationTimeMessage(BuildContext context) {
    final timeFormat = context.read<TimeFormatCubit>().state.timeFormat;
    return AppLocalizations.of(context)!.notificationTimeMaintenanceMessage(
      DateFormat(timeFormat.icuName).format(circulationClosingDate),
      closedDuration.durationToString(context),
    );
  }

  @override
  String getNotificationClosingMessage(BuildContext context) {
    return AppLocalizations.of(context)!.notificationClosingMaintenanceMessage(
      closedDuration.durationToString(
        context,
      ),
    );
  }

  @override
  RichText getInformationWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        children: [
          ...getCoreInformationWidget(context),
          TextSpan(
            text: AppLocalizations.of(context)!
                .dialogInformationContentBridge_closed_maintenance,
            style: TextStyle(
              color: colorScheme.maintenanceColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget getIconWidget(BuildContext context, bool reversed, double size) {
    return Icon(
      Icons.construction_rounded,
      color: getColor(context, reversed),
      size: size,
    );
  }

  @override
  Color getColor(BuildContext context, bool reversed) {
    return reversed
        ? Theme.of(context).dialogBackgroundColor
        : Theme.of(context).colorScheme.maintenanceColor;
  }

  @override
  String getClosingReason(BuildContext context) {
    return AppLocalizations.of(context)!
        .dialogInformationContentBridge_closed_maintenance
        .toUpperCase();
  }
}
