import 'package:chabo/models/boat.dart';
import 'package:chabo/models/boat_forecast.dart';
import 'package:chabo/models/enums/forecast_closing_type.dart';
import 'package:chabo/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final forecast = BoatForecast(
    totalClosing: true,
    circulationClosingDate: DateTime(2023, 5, 14, 15, 0),
    circulationReOpeningDate: DateTime(2023, 5, 14, 16, 0),
    boats: [Boat(name: 'TEST_BOAT', isLeaving: false)],
    closingType: ForecastClosingType.complete,
  );

  final forecast2 = BoatForecast(
    totalClosing: true,
    circulationClosingDate: DateTime(2023, 5, 14, 23, 0),
    circulationReOpeningDate: DateTime(2023, 5, 14, 05, 0),
    boats: [Boat(name: 'TEST_BOAT', isLeaving: false)],
    closingType: ForecastClosingType.complete,
  );

  group('BoatForecast TESTS', () {
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

    test('Is NOT overlaping with [TimeSlots]', () {
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

    test('Is NOT currently closed', () {
      final isOverlaping = forecast.isCurrentlyClosed();
      expect(isOverlaping, false);
    });

    test('Has passed', () {
      final isOverlaping = forecast.hasPassed();
      expect(isOverlaping, true);
    });

    test('Build from JSON - Boat arrival', () {
      var jsonValue1 = {
        'datasetid': 'previsions_pont_chaban',
        'recordid': '82c316d304b1adef7eeef9edc9ab7b257f766086',
        'fields': {
          'fermeture_totale': 'oui',
          'bateau': 'MARITE',
          'date_passage': '2023-03-02',
          're_ouverture_a_la_circulation': '16:49',
          'fermeture_a_la_circulation': '15:49',
          'type_de_fermeture': 'Totale',
        },
        'record_timestamp': '2023-04-25T13:32:05.809+02:00',
      };
      var jsonValue2 = {
        'datasetid': 'previsions_pont_chaban',
        'recordid': '82c316d304b1adef7eeef9edc9ab7b257f766086',
        'fields': {
          'fermeture_totale': 'oui',
          'bateau': 'MARITE',
          'date_passage': '2023-03-15',
          're_ouverture_a_la_circulation': '16:49',
          'fermeture_a_la_circulation': '15:49',
          'type_de_fermeture': 'Totale',
        },
        'record_timestamp': '2023-04-25T13:32:05.809+02:00',
      };
      final forecast1 = BoatForecast.fromJSON(jsonValue1);
      final forecast2 = BoatForecast.fromJSON(jsonValue2);

      expect(forecast1.boats[0].isLeaving, false);
      expect(forecast2.boats[0].isLeaving, true);
    });
  });
}
