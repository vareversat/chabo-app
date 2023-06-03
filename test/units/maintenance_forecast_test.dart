import 'package:chabo_app/models/enums/day.dart';
import 'package:chabo_app/models/enums/forecast_closing_type.dart';
import 'package:chabo_app/models/maintenance_forecast.dart';
import 'package:chabo_app/models/time_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'localized_testable_widget.dart';

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

  test('Is NOT currently closed', () {
    final isOverlaping = forecast.isCurrentlyClosed();
    expect(isOverlaping, false);
  });

  test('Has passed', () {
    final isOverlaping = forecast.hasPassed();
    expect(isOverlaping, true);
  });

  test('Get the correct closing duration', () {
    expect(forecast.closedDuration, const Duration(hours: 1));
  });

  group('Info TextSpan', () {
    testWidgets(
      'Display info TextSpan (same day)',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          localizedTestableWidget(
            child: Builder(
              builder: (BuildContext context) {
                final RichText richText =
                    forecast.getInformationWidget(context);
                expect(
                  richText.text.toPlainText(),
                  'Sunday, May 14, 2023 from ￼ to ￼, the Chaban bridge will be closed for maintenance\n\nClosing time : 1h',
                );

                return const Placeholder();
              },
            ),
          ),
        );
      },
    );

    testWidgets(
      'Display info TextSpan (tow days)',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          localizedTestableWidget(
            child: Builder(
              builder: (BuildContext context) {
                final RichText richText =
                    forecast2.getInformationWidget(context);
                expect(
                  richText.text.toPlainText(),
                  'From Sunday, May 14, 2023 ￼, to Monday, May 15, 2023 ￼, the Chaban bridge will be closed for maintenance\n\nClosing time : 6h',
                );

                return const Placeholder();
              },
            ),
          ),
        );
      },
    );
  });

  group('During two days or not', () {
    test('Is during 2 days', () {
      expect(forecast2.isDuringTwoDays, true);
    });

    test('Is NOT during 2 days', () {
      expect(forecast.isDuringTwoDays, false);
    });
  });

  group('Overlaping or not', () {
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

      const days = [Day.sunday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.monday, Day.sunday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.monday, Day.tuesday, Day.sunday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.sunday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.sunday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.monday, Day.sunday];
      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.monday, Day.sunday];
      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.sunday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
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

      const days = [Day.sunday];
      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1, days);
      expect(isOverlaping, false);
    });

    test('(3) Is NOT overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 14, minute: 00),
        to: TimeOfDay(
          hour: 15,
          minute: 30,
        ),
      );

      const days = [Day.thursday];
      final isOverlaping = forecast.isOverlappingWithTimeSlot(timeSlot1, days);
      expect(isOverlaping, false);
    });

    test('(4) Is NOT overlaping with [TimeSlots]', () {
      const timeSlot1 = TimeSlot(
        name: '',
        from: TimeOfDay(hour: 00, minute: 00),
        to: TimeOfDay(
          hour: 1,
          minute: 30,
        ),
      );

      const days = [Day.wednesday];
      final isOverlaping = forecast3.isOverlappingWithTimeSlot(timeSlot1, days);
      expect(isOverlaping, false);
    });
  });
}
