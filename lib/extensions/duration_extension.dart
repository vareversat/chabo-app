import 'package:flutter/material.dart';

extension DurationExtention on Duration {
  String durationToString() {
    if (inMinutes % 60 == 0) {
      return '${inHours.toString()}h';
    } else if (inHours == 0) {
      return '${inMinutes.toString()}mins';
    }
    return '${inHours.toString()}h ${(inMinutes % 60).toString()}mins';
  }

  TimeOfDay durationToTimeOfDay() {
    return TimeOfDay(hour: inHours, minute: inMinutes % 60);
  }
}
