import 'package:chabo/bloc/day_picker/day_picker_bloc.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayNotificationSettingsWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final DayPickerState state;

  const DayNotificationSettingsWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.state})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DayNotificationSettingsWidgetState();
  }
}

class _DayNotificationSettingsWidgetState
    extends State<DayNotificationSettingsWidget> with TickerProviderStateMixin {
  late final AnimationController _controllerAnimation = AnimationController(
    duration:
        const Duration(milliseconds: CustomProperties.animationDurationMs),
    vsync: this,
  );
  late final Animation<double> _settingsWidgetAnimation = CurvedAnimation(
    parent: _controllerAnimation,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    _controllerAnimation.dispose();
    super.dispose();
  }

  _toggleSettingsContainer() {
    if (_settingsWidgetAnimation.status != AnimationStatus.completed) {
      _controllerAnimation.forward();
      BlocProvider.of<DayPickerBloc>(context).add(
        DayPickerSettingChanged(
          isOpen: true,
        ),
      );
    } else {
      _controllerAnimation.animateBack(
        0,
        duration: const Duration(
          milliseconds: CustomProperties.animationDurationMs,
        ),
      );
      BlocProvider.of<DayPickerBloc>(context).add(
        DayPickerSettingChanged(
          isOpen: false,
        ),
      );
    }
  }

  Widget _buildChip(Day day, Day selectedDay) {
    final isSelected = selectedDay == day;
    return FilterChip(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      showCheckmark: false,
      label: Text(
        day.localizedName(context),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.tertiary),
      ),
      avatar: isSelected ? const Icon(Icons.check) : null,
      onSelected: (bool value) => {
        BlocProvider.of<DayPickerBloc>(context).add(
          DayPickerChanged(day: day),
        ),
      },
      selectedColor: Theme.of(context).colorScheme.primary,
      disabledColor: Theme.of(context).colorScheme.secondary,
      selected: isSelected,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(fontSize: 28),
                  ),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Switch(
                  value: widget.state.enabled,
                  onChanged: null,
                ),
                IconButton(
                  onPressed: () => {_toggleSettingsContainer()},
                  icon: AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    duration: const Duration(
                        milliseconds: CustomProperties.animationDurationMs),
                    child: Icon(
                      key: ValueKey<String>(widget.state.icon.toString()),
                      widget.state.icon,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: SizeTransition(
            sizeFactor: _settingsWidgetAnimation,
            child: Wrap(
              spacing: 5,
              children: Day.values
                  .map((day) => _buildChip(day, widget.state.day))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
