import 'package:chabo/models/enums/forecast_closing_type.dart';
import 'package:chabo/models/maintenance_forecast.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final forecast = MaintenanceForecast(
    totalClosing: true,
    circulationClosingDate: DateTime(2023, 5, 14, 15, 0),
    circulationReOpeningDate: DateTime(2023, 5, 14, 16, 0),
    closingType: ForecastClosingType.complete,
  );

  final forecast2 = MaintenanceForecast(
    totalClosing: true,
    circulationClosingDate: DateTime(2023, 5, 14, 23, 0),
    circulationReOpeningDate: DateTime(2023, 5, 14, 05, 0),
    closingType: ForecastClosingType.complete,
  );

  final forecast3 = MaintenanceForecast(
    totalClosing: true,
    circulationClosingDate: DateTime(2023, 5, 14, 23, 0),
    circulationReOpeningDate: DateTime(2023, 5, 15, 05, 0),
    closingType: ForecastClosingType.complete,
  );

  group('MaintenanceForecast TESTS', () {
    test('Is during 2 days', () {
      expect(forecast2.isDuringTwoDays, true);
    });

    test('Is NOT during 2 days', () {
      expect(forecast.isDuringTwoDays, false);
    });

    test('Get the correct closing duration', () {
      expect(forecast.closedDuration, const Duration(hours: 1));
    });

    test('Is overlaping with', () {
      final isOverlaping =
          forecast.isOverlappingWith(DateTime(2023, 5, 14, 15, 30));
      expect(isOverlaping, true);
    });

    test('Is NOT overlaping with', () {
      final isOverlaping =
          forecast.isOverlappingWith(DateTime(2023, 5, 14, 17, 30));
      expect(isOverlaping, false);
    });

    test('(1) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 14, minute: 00),
        to: TimeOfDay(
          hour: 15,
          minute: 30,
        ),
      );

      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(2) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 15, minute: 30),
        to: TimeOfDay(
          hour: 15,
          minute: 45,
        ),
      );

      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(3) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 12, minute: 30),
        to: TimeOfDay(
          hour: 18,
          minute: 30,
        ),
      );

      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(4) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 15, minute: 30),
        to: TimeOfDay(
          hour: 18,
          minute: 30,
        ),
      );

      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(5) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 15, minute: 30),
        to: TimeOfDay(
          hour: 18,
          minute: 30,
        ),
      );

      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(6) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 23, minute: 00),
        to: TimeOfDay(
          hour: 23,
          minute: 30,
        ),
      );

      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(7) Is overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 00, minute: 00),
        to: TimeOfDay(
          hour: 1,
          minute: 30,
        ),
      );

      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, true);
    });

    test('(1) Is NOT overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 19, minute: 00),
        to: TimeOfDay(
          hour: 20,
          minute: 00,
        ),
      );

      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, false);
    });

    test('(2) Is NOT overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 7, minute: 00),
        to: TimeOfDay(
          hour: 8,
          minute: 30,
        ),
      );

      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1);
      expect(isOverlaping, false);
    });

    test('Is NOT currently closed', () {
      final isOverlaping = forecast.isCurrentlyClosed();
      expect(isOverlaping, false);
    });

    test('Has passed', () {
      final isOverlaping = forecast.hasPassed();
      expect(isOverlaping, true);
    });
  });
}
