import 'dart:async';
import 'dart:ui';

import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/dialogs/credits_dialog.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:chabo_app/widgets/chabo_app_bar/chabo_app_bar.dart';
import 'package:chabo_app/widgets/current_docked_boat_button.dart';
import 'package:chabo_app/widgets/forecast/forecast_widget.dart';
import 'package:chabo_app/widgets/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:chabo_app/widgets/wave_divider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'duration_widget.dart';

part 'status_image_widget.dart';

class StatusScreen extends StatefulWidget {
  static const routeName = '/status-screen';

  const StatusScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StatusScreenState();
  }
}

class StatusScreenState extends CustomWidgetState<StatusScreen> {
  StatusScreenState() : super(screenName: 'status-screen');

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (mounted) {
          BlocProvider.of<StatusBloc>(context)
              .add(StatusRefresh(context: context));
        } else {
          t.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChaboAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(CustomProperties.padding),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: BlocBuilder<StatusBloc, StatusState>(
                  builder: (context, statusState) {
                    return AnimatedSwitcher(
                      duration: const Duration(
                        milliseconds: CustomProperties.animationDurationMs,
                      ),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                      child:
                          statusState.statusLifecycle ==
                              StatusLifecycle.populated
                          ? Column(
                              spacing: 10,
                              children: [
                                StatusImageWidget(statusState: statusState),
                                CurrentDockedBoatButton(
                                  statusState: statusState,
                                ),
                                WaveDivider(),
                                DurationWidget(statusState: statusState),
                                ForecastWidget(
                                  isCurrent: true,
                                  hasPassed: false,
                                  forecast: statusState.currentForecast!,
                                  borderColor: statusState.backgroundColor,
                                  index: 0,
                                  timeSlots: [],
                                ),
                              ],
                            )
                          : CustomCircularProgressIndicator(
                              message: AppLocalizations.of(context)!.loading,
                            ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
