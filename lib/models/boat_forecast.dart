import 'package:chabo_app/const.dart';
import 'package:chabo_app/cubits/time_format_cubit.dart';
import 'package:chabo_app/extensions/boats_extension.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/extensions/duration_extension.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/models/boat.dart';
import 'package:chabo_app/models/enums/forecast_closing_reason.dart';
import 'package:chabo_app/models/enums/forecast_closing_type.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

class BoatForecast extends AbstractForecast {
  final List<Boat> boats;

  static final List<String> allBoatNames = [];

  BoatForecast({
    required super.totalClosing,
    required super.circulationClosingDate,
    required super.circulationReOpeningDate,
    required this.boats,
    required super.closingType,
  }) : assert(boats.isNotEmpty),
       super(closingReason: ForecastClosingReason.boat);

  factory BoatForecast.fake() {
    return BoatForecast(
      totalClosing: true,
      circulationClosingDate: DateTime.now(),
      circulationReOpeningDate: DateTime.now(),
      boats: [Boat.fake()],
      closingType: ForecastClosingType.complete,
    );
  }

  factory BoatForecast.fromJSON(Map<String, dynamic> json) {
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

    List<Boat> boats = [];
    bool isLeaving = false;
    final rawBoatName = json['fields']['bateau'] as String;
    // For multi boat events, extract all the boat name
    final boatNames = rawBoatName.split(RegExp(Const.multiBoatsEventSeparator));
    for (final boatName in boatNames) {
      final trimmedBoatName = boatName.trim();
      isLeaving = allBoatNames.contains(trimmedBoatName);
      boats.add(Boat(name: trimmedBoatName, isLeaving: isLeaving));
      if (isLeaving) {
        allBoatNames.remove(trimmedBoatName);
      } else {
        allBoatNames.add(trimmedBoatName);
      }
    }

    return BoatForecast(
      boats: boats,
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
    boats,
    circulationClosingDate,
    circulationReOpeningDate,
    closingType,
  ];

  @override
  String getNotificationDurationMessage(
    BuildContext context,
    String pickedDuration,
  ) {
    return AppLocalizations.of(context)!.notificationDurationBoatMessage(
      boats.toLocalizedString(context),
      pickedDuration,
      closedDuration.durationToString(context),
    );
  }

  @override
  String getNotificationTimeMessage(BuildContext context) {
    final timeFormat = context.read<TimeFormatCubit>().state.timeFormat;
    return AppLocalizations.of(context)!.notificationTimeBoatMessage(
      boats.toLocalizedString(context),
      intl.DateFormat(timeFormat.icuName).format(circulationClosingDate),
      closedDuration.durationToString(context),
    );
  }

  @override
  String getNotificationClosingMessage(BuildContext context) {
    return AppLocalizations.of(context)!.notificationClosingBoatMessage(
      boats.toLocalizedString(context),
      closedDuration.durationToString(context),
    );
  }

  @override
  String getCalendarEventClosingDescription(BuildContext context) {
    return AppLocalizations.of(context)!.calendarEventBoatDescription(
      boats.toLocalizedString(context),
      closedDuration.durationToString(context),
    );
  }

  List<String> _generateCrossingTimes(DateTime t, int n, int p) {
    // Calculate the step in seconds
    int stepInSeconds = p;

    // Generate the list of times
    List<String> result = [];
    for (int i = 0; i < n; i++) {
      // Calculate the offset for the current time in seconds
      double offset = (i - (n - 1) / 2.0) * stepInSeconds;
      int offsetInSeconds = offset.round();

      // Create a new DateTime by adding the offset
      DateTime newTime = t.add(Duration(seconds: offsetInSeconds));

      // Format the time as HH:MM:SS (or HH:MM if seconds are zero)
      String formattedTime =
          '${newTime.hour.toString().padLeft(2, '0')}h'
          '${newTime.minute.toString().padLeft(2, '0')}';

      result.add(formattedTime);
    }

    return result;
  }

  @override
  Widget getDetailedInfo(BuildContext context) {
    var halfDuration = Duration(seconds: closedDuration.inSeconds ~/ 2);
    var medianTime = circulationClosingDate.add(halfDuration);
    var crossingTimes = _generateCrossingTimes(medianTime, boats.length, 1800);
    return Column(
      spacing: 13,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3,
          children: boats.asMap().entries.map((elem) {
            final boat = elem.value;
            final index = elem.key;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(text: boat.toLocalizedTextSpan(context, true)),
                Row(
                  spacing: 5,
                  children: [
                    Text(
                      boat.isLeaving
                          ? AppLocalizations.of(context)!
                                .bottomSheetAdditionalInfo_boatArriving
                          : AppLocalizations.of(context)!
                                .bottomSheetAdditionalInfo_boatLeaving,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('-  ${crossingTimes[index]}'),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
        Text(
          AppLocalizations.of(context)!
              .bottomSheetAdditionalInfo_boatCrossingTimeDisclaimer,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontStyle: FontStyle.italic,
            color: Theme.of(context).colorScheme.inverseSurface
                .withValues(alpha: .4),
          ),
        ),
      ],
    );
  }

  @override
  String getBottomSheetTitle(BuildContext context) {
    return AppLocalizations.of(context)!.bottomSheetTitle_boat;
  }

  @override
  Widget getIconWidget(
    BuildContext context,
    bool reversed,
    double size,
    bool isLight,
  ) {
    var iconData = boats.isWineFestival()
        ? Icons.wine_bar_outlined
        : Icons.directions_boat_filled_outlined;

    return Icon(iconData, color: getColor(context, reversed), size: size);
  }

  @override
  Color getColor(BuildContext context, bool reversed) {
    if (boats.isWineFestival()) {
      return reversed
          ? Theme.of(context).colorScheme.surface
          : Theme.of(context).colorScheme.bordeauxColor;
    }

    return reversed
        ? Theme.of(context).colorScheme.surface
        : Theme.of(context).colorScheme.boatColor;
  }

  @override
  Map<String, dynamic> toJson() {
    var json = super.toJson();
    json.addAll({'boats': boats.map((e) => e.toJson()).toList()});

    return json;
  }
}
