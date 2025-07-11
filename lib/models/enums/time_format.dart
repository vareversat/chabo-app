enum TimeFormat { twelveHours, twentyFourHours }

extension TimeFormatExtension on TimeFormat? {
  String get text {
    switch (this) {
      case TimeFormat.twelveHours:
        return '12h';
      case TimeFormat.twentyFourHours:
        return '24h';
      default:
        return 'no_value';
    }
  }

  String get icuName {
    switch (this) {
      case TimeFormat.twelveHours:
        return 'h:mm a';
      case TimeFormat.twentyFourHours:
        return 'HH:mm';
      default:
        return 'no_value';
    }
  }
}
