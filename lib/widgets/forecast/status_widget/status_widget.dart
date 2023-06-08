import 'dart:async';

import 'package:chabo/bloc/scroll_status/scroll_status_bloc.dart';
import 'package:chabo/bloc/status/status_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/custom_widget_state.dart';
import 'package:chabo/extensions/boats_extension.dart';
import 'package:chabo/extensions/color_scheme_extension.dart';
import 'package:chabo/extensions/duration_extension.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/models/boat_forecast.dart';
import 'package:chabo/widgets/bottom_sheets/current_docked_boat_bottom_sheet.dart';
import 'package:chabo/widgets/forecast/forecast_widget/forecast_widget.dart';
import 'package:chabo/widgets/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:chabo/widgets/progress_indicator/custom_progress_bar_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'current_docked_boat_button.dart';

part 'current_status_widget.dart';
part 'layout_widget.dart';
part 'progress_indicator_widget.dart';
part 'text_widget.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return StatusWidgetState();
  }
}

class StatusWidgetState extends CustomWidgetState<StatusWidget> {
  StatusWidgetState() : super(screenName: 'status-widget');

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          Timer.periodic(
            const Duration(seconds: 1),
            (Timer t) => BlocProvider.of<StatusBloc>(context).add(
              StatusRefresh(
                context: context,
              ),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          reverseDuration: const Duration(
            milliseconds: CustomProperties.shortAnimationDurationMs,
          ),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: state.statusLifecycle == StatusLifecycle.empty
              ? CustomCircularProgressIndicator(
                  message: AppLocalizations.of(context)!.statusLoadMessage,
                )
              : _LayoutWidget(
                  statusState: state,
                ),
        );
      },
    );
  }
}
