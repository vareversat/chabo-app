import 'package:chabo/bloc/status/status_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/extensions/boats_extension.dart';
import 'package:chabo/models/boat_forecast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentDockedBoatItem extends StatelessWidget {
  const CurrentDockedBoatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<StatusBloc, StatusState>(
        builder: (context, state) {
          /// Check if previousForecast is not null, if its a BoatForecast and that the string status is not empty
          return AnimatedSwitcher(
            duration: const Duration(
              milliseconds: CustomProperties.shortAnimationDurationMs,
            ),
            reverseDuration: const Duration(
              milliseconds: CustomProperties.shortAnimationDurationMs,
            ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: state.previousForecast != null &&
                    state.previousForecast is BoatForecast &&
                    (state.previousForecast as BoatForecast)
                            .boats
                            .toLocalizedMoonHarborStatus(context) !=
                        ''
                ? Container(
                    decoration: BoxDecoration(
                      color: state.previousForecast!.getColor(context, false),
                      border: Border.all(
                        width: 0,
                        color: Colors.transparent,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          CustomProperties.borderRadius / 2,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (state.previousForecast as BoatForecast)
                            .boats
                            .toLocalizedMoonHarborStatus(
                              context,
                            ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: state.previousForecast!.getColor(
                                context,
                                true,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
