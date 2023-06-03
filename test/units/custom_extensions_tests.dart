import 'package:chabo_app/extensions/date_time_extension.dart';
import 'package:chabo_app/extensions/string_extension.dart';
import 'package:chabo_app/extensions/time_of_day_extension.dart';
import 'package:chabo_app/models/enums/day.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../localized_testable_widget.dart';

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

  test('Previous 1', () {
    const day = Day.monday;
    final dateTime = DateTime(2023, 5, 14, 15, 0);
    final previousMonday = dateTime.previous(day.weekPosition);
    expect(previousMonday, DateTime(2023, 5, 8, 0, 0));
  });

  test('Previous 2', () {
    const day = Day.sunday;
    final dateTime = DateTime(2023, 5, 14, 15, 0);
    final previousMonday = dateTime.previous(day.weekPosition);
    expect(previousMonday, DateTime(2023, 5, 7, 0, 0));
  });

  test('Previous 3', () {
    const day = Day.saturday;
    final dateTime = DateTime(2023, 5, 14, 15, 0);
    final previousMonday = dateTime.previous(day.weekPosition);
    expect(previousMonday, DateTime(2023, 5, 13, 0, 0));
  });

  test('Previous 4', () {
    const day = Day.saturday;
    final dateTime = DateTime(2023, 5, 11, 15, 0);
    final previousMonday = dateTime.previous(day.weekPosition);
    expect(previousMonday, DateTime(2023, 5, 6, 0, 0));
  });
}
