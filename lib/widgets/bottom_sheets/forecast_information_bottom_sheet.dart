import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/extensions/date_time_extension.dart';
import 'package:chabo_app/helpers/custom_page_routes.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/models/abstract_forecast.dart';
import 'package:chabo_app/screens/notification_screen/notification_screen.dart';
import 'package:chabo_app/service/event_share_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ForecastInformationBottomSheet extends StatefulWidget {
  final AbstractForecast forecast;

  const ForecastInformationBottomSheet({super.key, required this.forecast});

  @override
  State<StatefulWidget> createState() {
    return _ForecastInformationBottomSheetState();
  }
}

class _ForecastInformationBottomSheetState
    extends State<ForecastInformationBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final Tween<double> _tween = Tween(begin: 0, end: 1);
  final _duration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _duration, vsync: this);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final appLocalization = AppLocalizations.of(context);
    final warning = widget.forecast.interferingTimeSlots.isNotEmpty;

    Sentry.addBreadcrumb(
      Breadcrumb(
        message: 'Open ForecastInformationBottomSheet',
        level: SentryLevel.info,
        category: 'screen.open',
        type: 'Screen',
        data: widget.forecast.toJson(),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScaleTransition(
                scale: _tween.animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.elasticOut,
                  ),
                ),
                child: widget.forecast.getIconWidget(context, false, 20, true),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.forecast.getBottomSheetTitle(context),
                  style: textTheme.titleLarge,
                ),
              ),
            ],
          ),
          if (warning) _TimeSlotWarning(tween: _tween, duration: _duration),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _TimeWidget(
                isWarning: warning,
                date: widget.forecast.circulationClosingDate
                    .toLocalizedTextSpan(
                      context,
                      Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                text: appLocalization!.circulationClosing.toUpperCase(),
              ),
              FaIcon(FontAwesomeIcons.arrowRight, size: 20),
              _TimeWidget(
                isWarning: warning,
                date: widget.forecast.circulationReOpeningDate
                    .toLocalizedTextSpan(
                      context,
                      Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                text: appLocalization.circulationReOpening.toUpperCase(),
              ),
            ],
          ),
          Column(
            spacing: 15,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme.surfaceContainerHigh,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(
                    CustomProperties.borderRadius,
                  ),
                ),
                child: widget.forecast.getDetailedInfo(context),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.forecast.getColor(context, false),
                    foregroundColor: widget.forecast.getColor(context, true),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(CustomProperties.borderRadius),
                      ),
                    ),
                  ),
                  onPressed: () =>
                      EventShareService.addToCalendar(context, widget.forecast),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      const FaIcon(FontAwesomeIcons.calendarPlus, size: 20),
                      Text(
                        appLocalization.calendarEventAddToCalendar,
                        style: textTheme.titleMedium?.copyWith(
                          color: widget.forecast.getColor(context, true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: widget.forecast.getColor(context, false),
                    side: BorderSide(
                      width: 3,
                      color: widget.forecast.getColor(context, false),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(CustomProperties.borderRadius),
                      ),
                    ),
                  ),
                  onPressed: () =>
                      EventShareService.shareEvent(context, widget.forecast),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      const FaIcon(FontAwesomeIcons.shareNodes, size: 20),
                      Text(
                        appLocalization.shareEventTitle,
                        style: textTheme.titleMedium?.copyWith(
                          color: widget.forecast.getColor(context, false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TimeWidget extends StatelessWidget {
  final TextSpan date;
  final String text;
  final bool isWarning;

  const _TimeWidget({
    required this.date,
    required this.text,
    required this.isWarning,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomProperties.borderRadius),
        border: Border.all(
          color: isWarning
              ? colorScheme.warningColor.withValues(alpha: 0.5)
              : Colors.transparent,
          width: 3,
        ),
        color: colorScheme.surfaceContainerHigh,
      ),
      child: SizedBox(
        height: 70,
        width: 150,
        child: Stack(
          children: [
            Positioned(
              top: 2,
              left: 15,
              child: Text(
                text,
                style: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            Positioned(top: 30, left: 15, child: RichText(text: date)),
          ],
        ),
      ),
    );
  }
}

class _TimeSlotWarning extends StatelessWidget {
  final Tween<double> tween;
  final Duration duration;

  const _TimeSlotWarning({required this.tween, required this.duration});

  /// convert 0-1 to 0-1-0
  double shake(double animation) =>
      2 * (0.5 - (0.5 - Curves.bounceOut.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.warning_rounded,
            size: 25,
            color: colorScheme.warningColor,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              AppLocalizations.of(context)!.favoriteSlotsInterferenceWarning,
              overflow: TextOverflow.clip,
              style: textTheme.labelLarge?.copyWith(
                color: colorScheme.warningColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                colorScheme.warningColor,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(
                colorScheme.surface,
              ),
            ),
            onPressed: () => {
              Navigator.of(context).pop(),
              Navigator.of(context).push(
                LeftToRightPageRoute(
                  builder: (context) =>
                      const NotificationScreen(highlightTimeSlots: true),
                  settings: const RouteSettings(
                    name: NotificationScreen.routeName,
                  ),
                ),
              ),
            },
            child: TweenAnimationBuilder<double>(
              tween: tween,
              duration: duration,
              builder: (context, animation, child) => Transform.translate(
                offset: Offset(20 * shake(animation), 0),
                child: child,
              ),
              child: const Icon(Icons.notifications_active),
            ),
          ),
        ],
      ),
    );
  }
}
