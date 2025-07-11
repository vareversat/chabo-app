import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot extends Equatable {
  final String name;
  final TimeOfDay from;
  final TimeOfDay to;

  const TimeSlot({required this.name, required this.from, required this.to});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'from': '${from.hour}:${from.minute}',
      'to': '${to.hour}:${to.minute}',
    };
  }

  factory TimeSlot.fromJSON(Map<String, dynamic> json) {
    final format = DateFormat.Hm();

    return TimeSlot(
      name: json['name'] ?? '',
      from: TimeOfDay.fromDateTime(format.parse(json['from'])),
      to: TimeOfDay.fromDateTime(format.parse(json['to'])),
    );
  }

  @override
  List<Object?> get props => [name, from, to];
}
