import 'package:chabo/bloc/status/status_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/extensions/boats_extension.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/models/boat_forecast.dart';
import 'package:chabo/widgets/bottom_sheets/current_docked_boat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentDockedBoatButton extends StatelessWidget {
  const CurrentDockedBoatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusState>(
      builder: (context, statusState) {
        return AnimatedSwitcher(
          duration: const Duration(
            seconds: 1,
          ),
          reverseDuration: const Duration(milliseconds: 0),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },

          /// Check if previousForecast is not null, if its a BoatForecast and that the string status is not empty
          child: statusState.previousForecast != null &&
                  statusState.previousForecast is BoatForecast &&
                  (statusState.previousForecast as BoatForecast)
                      .boats
                      .oneIsArriving()
              ? ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).colorScheme.boatColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).cardColor,
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          CustomProperties.borderRadius,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => {
                    showModalBottomSheet(
                      useSafeArea: false,
                      barrierColor: Colors.black.withOpacity(0.65),
                      constraints: BoxConstraints(
                        maxWidth: DeviceHelper.isPortrait(context)
                            ? double.infinity
                            : MediaQuery.of(context).size.width / 2.5,
                      ),
                      enableDrag: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                            CustomProperties.borderRadius * 2,
                          ),
                        ),
                      ),
                      builder: (context) {
                        return CurrentDockedBoatBottomSheet(
                          statusState: statusState,
                        );
                      },
                    ),
                  },
                  icon: const Icon(Icons.info),
                  label: Text(
                    AppLocalizations.of(context)!.moonHarborShortStatus(
                      (statusState.previousForecast as BoatForecast)
                          .boats
                          .length,
                    ),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).cardColor,
                          fontWeight: FontWeight.bold,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
