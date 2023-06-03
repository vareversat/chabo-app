import 'package:chabo/extensions/date_time_extension.dart';
import 'package:chabo/extensions/string_extension.dart';
import 'package:chabo/models/enums/day.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtensions TEST', () {
    test('Capitalize', () {
      const string = 'test';
      expect(string.capitalize(), 'Test');
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
