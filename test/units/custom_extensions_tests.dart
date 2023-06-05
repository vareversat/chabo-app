import 'package:chabo/extensions/date_time_extension.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('string_extension', () {
    test('capitalize', () {
      const string = 'test';
      expect(string.capitalize(), 'Test');
    });
    test('startsWithVowel - true', () {
      const string = 'test';
      expect(string.startsWithVowel(), false);
    });
    test('startsWithVowel - false', () {
      const string = 'itest';
      expect(string.startsWithVowel(), true);
    });
  });

  group('date_time_extension', () {
    test('previous 1', () {
      const day = Day.monday;
      final dateTime = DateTime(2023, 5, 14, 15, 0);
      final previousMonday = dateTime.previous(day.weekPosition);
      expect(previousMonday, DateTime(2023, 5, 8, 0, 0));
    });

    test('previous 2', () {
      const day = Day.sunday;
      final dateTime = DateTime(2023, 5, 14, 15, 0);
      final previousMonday = dateTime.previous(day.weekPosition);
      expect(previousMonday, DateTime(2023, 5, 7, 0, 0));
    });

    test('previous 3', () {
      const day = Day.saturday;
      final dateTime = DateTime(2023, 5, 14, 15, 0);
      final previousMonday = dateTime.previous(day.weekPosition);
      expect(previousMonday, DateTime(2023, 5, 13, 0, 0));
    });

    test('previous 4', () {
      const day = Day.saturday;
      final dateTime = DateTime(2023, 5, 11, 15, 0);
      final previousMonday = dateTime.previous(day.weekPosition);
      expect(previousMonday, DateTime(2023, 5, 6, 0, 0));
    });
  });
}
