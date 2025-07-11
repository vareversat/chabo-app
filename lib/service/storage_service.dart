import 'dart:convert';
import 'dart:developer' as developer;

import 'package:chabo_app/models/enums/day.dart';
import 'package:chabo_app/models/enums/theme_state_status.dart';
import 'package:chabo_app/models/enums/time_format.dart';
import 'package:chabo_app/models/time_slot.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences sharedPreferences;

  StorageService({required this.sharedPreferences});

  Future<bool> saveString(String key, String message) async {
    developer.log('{$key: $message}', name: 'storage-service.on.saveString');

    return await sharedPreferences.setString(key, message);
  }

  Future<bool> saveBool(String key, bool value) async {
    developer.log('{$key: $value}', name: 'storage-service.on.saveBool');

    return await sharedPreferences.setBool(key, value);
  }

  Future<bool> saveDuration(String key, Duration value) async {
    developer.log('{$key: $value}', name: 'storage-service.on.saveDuration');

    return await sharedPreferences.setString(key, value.inMinutes.toString());
  }

  Future<bool> saveTimeOfDay(String key, TimeOfDay value) async {
    developer.log('{$key: $value}', name: 'storage-service.on.saveTimeOfDay');

    return await sharedPreferences.setString(
      key,
      '${value.hour.toString()}:${value.minute.toString()}',
    );
  }

  Future<bool> saveDay(String key, Day value) async {
    developer.log('{$key: $value}', name: 'storage-service.on.saveDay');

    return await sharedPreferences.setString(key, value.name);
  }

  Future<bool> saveDays(String key, List<Day> days) async {
    developer.log('{$key: $days}', name: 'storage-service.on.saveDays');

    final stringValue = days
        .map((e) => EnumToString.convertToString(e))
        .toList();

    return await sharedPreferences.setString(key, json.encode(stringValue));
  }

  Future<bool> saveTheme(String key, ThemeStateStatus value) async {
    developer.log('{$key: $value}', name: 'storage-service.on.saveTheme');

    return await sharedPreferences.setString(key, value.name);
  }

  Future<bool> saveTimeSlots(String key, List<TimeSlot> timeSlots) async {
    developer.log(
      '{$key: $timeSlots}',
      name: 'storage-service.on.saveTimeSlots',
    );

    return await sharedPreferences.setString(key, jsonEncode(timeSlots));
  }

  Future<bool> saveTimeFormat(String key, TimeFormat value) async {
    developer.log('{$key: $value}', name: 'storage-service.on.saveTimeFormat');

    return await sharedPreferences.setString(key, value.name);
  }

  String? readString(String key) {
    final value = sharedPreferences.getString(key);
    developer.log('{$key: $value}', name: 'storage-service.on.readString');

    return value;
  }

  bool? readBool(String key) {
    final value = sharedPreferences.getBool(key);
    developer.log('{$key: $value}', name: 'storage-service.on.readBool');

    return value;
  }

  Duration? readDuration(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final value = Duration(
        minutes: int.parse(sharedPreferences.getString(key)!),
      );
      developer.log('{$key: $value}', name: 'storage-service.on.readDuration');

      return value;
    }
  }

  TimeOfDay? readTimeOfDay(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final value = TimeOfDay.fromDateTime(
        DateFormat('hh:mm').parse(sharedPreferences.getString(key)!),
      );
      developer.log('{$key: $value}', name: 'storage-service.on.readTimeOfDay');

      return value;
    }
  }

  Day? readDay(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final value = EnumToString.fromString(Day.values, stringValue);
      developer.log('{$key: $value}', name: 'storage-service.on.readDay');

      return value;
    }
  }

  List<Day>? readDays(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final list = json.decode(stringValue);
      final List<Day?> days = list
          .map<Day?>((item) => EnumToString.fromString(Day.values, item))
          .toList();
      days.removeWhere((element) => element == null);
      developer.log('{$key: $days', name: 'storage-service.on.readDays');

      return days.nonNulls.toList();
    }
  }

  ThemeStateStatus? readTheme(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final value = EnumToString.fromString(
        ThemeStateStatus.values,
        stringValue,
      );
      developer.log('{$key: $value}', name: 'storage-service.on.readTheme');

      return value;
    }
  }

  List<TimeSlot>? readTimeSlots(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final list = json.decode(stringValue);
      final List<TimeSlot> timeSlotList = list
          .map<TimeSlot>((item) => TimeSlot.fromJSON(item))
          .toList();
      developer.log(
        '{$key: $timeSlotList',
        name: 'storage-service.on.readTimeSlots',
      );

      return timeSlotList;
    }
  }

  TimeFormat? readTimeFormat(String key) {
    final stringValue = sharedPreferences.getString(key);
    if (stringValue == null) {
      return null;
    } else {
      final value = EnumToString.fromString(TimeFormat.values, stringValue);
      developer.log(
        '{$key: $value}',
        name: 'storage-service.on.readTimeFormat',
      );

      return value;
    }
  }
}
