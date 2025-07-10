class DaySelector {
  /// List of days, matching Dart's DateTime.weekday numbering:
  /// DateTime.weekday: 1 = Monday, ..., 7 = Sunday
  static const List<String> days = [
    'Monday',    // index 0 -> weekday 1
    'Tuesday',   // index 1 -> weekday 2
    'Wednesday', // index 2 -> weekday 3
    'Thursday',  // index 3 -> weekday 4
    'Friday',    // index 4 -> weekday 5
    'Saturday',  // index 5 -> weekday 6
    'Sunday',    // index 6 -> weekday 7
  ];

  /// Get the current weekday name according to the real calendar.
  static String selectWeekDay() {
    return days[DateTime.now().weekday - 1];
  }

  /// Custom logic: if today is Saturday, Monday, or Wednesday, return 'Saturday'.
  /// Else return 'Sunday'.
  static String selectClassDay() {
    String today = selectWeekDay();

    if (today == 'Saturday' || today == 'Monday' || today == 'Wednesday') {
      return 'Saturday';
    } else {
      return 'Sunday';
    }
  }
}
