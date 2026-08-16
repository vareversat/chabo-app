import 'package:chabo_app/models/enums/day.dart';
import 'package:chabo_app/models/enums/theme_state_status.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/models/time_slot.dart';
import 'package:chabo_app/service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late final StorageService storageService;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    storageService = StorageService(sharedPreferences: sharedPreferences);
  });

  test('Save & Read String', () async {
    final saveResult = await storageService.saveString('KEY_STRING', 'STRING');
    final readResult = storageService.readString('KEY_STRING');
    expect(saveResult, true);
    expect(readResult, 'STRING');
  });

  test('Save & Read Bool', () async {
    final saveResult = await storageService.saveBool('KEY_BOOL', false);
    final readResult = storageService.readBool('KEY_BOOL');
    expect(saveResult, true);
    expect(readResult, false);
  });

  test('Save & Read Duration', () async {
    final saveResult = await storageService.saveDuration(
      'KEY_DURATION',
      const Duration(
        hours: 1,
      ),
    );
    final readResult = storageService.readDuration('KEY_DURATION');
    expect(saveResult, true);
    expect(readResult, const Duration(hours: 1));
  });

  test('Save & Read TimeOfDay', () async {
    final saveResult = await storageService.saveTimeOfDay(
      'KEY_TIMEOFDAY',
      const TimeOfDay(
        hour: 13,
        minute: 20,
      ),
    );
    final readResult = storageService.readTimeOfDay('KEY_TIMEOFDAY');
    expect(saveResult, true);
    expect(readResult, const TimeOfDay(hour: 13, minute: 20));
  });

  test('Save & Read Day', () async {
    final saveResult = await storageService.saveDay(
      'KEY_DAY',
      Day.monday,
    );
    final readResult = storageService.readDay('KEY_DAY');
    expect(saveResult, true);
    expect(readResult, Day.monday);
  });

  test('Save & Read Theme', () async {
    final saveResult = await storageService.saveTheme(
      'KEY_THEME',
      ThemeStateStatus.light,
    );
    final readResult = storageService.readTheme('KEY_THEME');
    expect(saveResult, true);
    expect(readResult, ThemeStateStatus.light);
  });

  test('Save & Read TimeSlots', () async {
    final timeSlots = [
      const TimeSlot(
        name: '',
        from: TimeOfDay(hour: 8, minute: 0),
        to: TimeOfDay(hour: 10, minute: 0),
      ),
      const TimeSlot(
        name: '',
        from: TimeOfDay(hour: 18, minute: 0),
        to: TimeOfDay(hour: 20, minute: 0),
      ),
    ];
    final saveResult = await storageService.saveTimeSlots(
      'KEY_TIMESLOTS',
      timeSlots,
    );
    final readResult = storageService.readTimeSlots('KEY_TIMESLOTS');
    expect(saveResult, true);
    expect(readResult, timeSlots);
  });

  test('Save & Read Days', () async {
    final days = [
      Day.monday,
      Day.tuesday,
    ];
    final saveResult = await storageService.saveDays(
      'KEY_DAYS',
      days,
    );
    final readResult = storageService.readDays('KEY_DAYS');
    expect(saveResult, true);
    expect(readResult, days);
  });

  test('Save & Read TimeFormat', () async {
    final saveResult = await storageService.saveTimeFormat(
      'KEY_TIMEFORMAT',
      TimeFormat.twentyFourHours,
    );
    final readResult = storageService.readTimeFormat('KEY_TIMEFORMAT');
    expect(saveResult, true);
    expect(readResult, TimeFormat.twentyFourHours);
  });
}
