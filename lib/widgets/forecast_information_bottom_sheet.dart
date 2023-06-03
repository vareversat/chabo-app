import 'package:chabo/custom_properties.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/helpers/custom_page_routes.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/models/abstract_forecast.dart';
import 'package:chabo/screens/notification_screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForecastInformationBottomSheet extends StatefulWidget {
  final AbstractForecast forecast;

  const ForecastInformationBottomSheet({
    super.key,
    required this.forecast,
  });

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

    _controller = AnimationController(
      duration: _duration,
      vsync: this,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double shake(double animation) =>
      2 * (0.5 - (0.5 - Curves.bounceOut.transform(animation)).abs());

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScaleTransition(
                scale: _tween.animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.elasticOut,
                  ),
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: widget.forecast.getColor(context, false),
                  child: widget.forecast.getIconWidget(context, true, 30, true),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
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
                  child: widget.forecast.getInformationWidget(context),
                ),
              ),
            ],
          ),
        ),
        if (widget.forecast.interferingTimeSlots.isNotEmpty)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      CustomProperties.borderRadius,
                    ),
                  ),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                        child: TweenAnimationBuilder<double>(
                          tween: _tween,
                          duration: _duration,
                          builder: (context, animation, child) =>
                              Transform.translate(
                            offset: Offset(20 * shake(animation), 0),
                            child: child,
                          ),
                          child: const Icon(
                            Icons.notifications_active,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
