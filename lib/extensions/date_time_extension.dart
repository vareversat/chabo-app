extension DateTimeExtension on DateTime {
  DateTime previous(int day) {
    if (day == weekday) {
      return subtract(const Duration(days: 7));
    } else {
      return subtract(
        Duration(
            days: (weekday - day) % DateTime.daysPerWeek,
            hours: hour,
            minutes: minute),
      );
    }
  }
}
