class TimeSlotUtils {
  static String? autoSelectTimeSlot({required bool isTest}) {
    String? selectedTimeSlot;
    final currentHour = DateTime.now().hour;

    if (currentHour >= 8 && currentHour < 10) {
      selectedTimeSlot = '8:00 - 10:00';
    } else if (currentHour >= 10 && currentHour < 12) {
      selectedTimeSlot = '10:00 - 12:00';
    } else if (currentHour >= 12 && currentHour < 14) {
      selectedTimeSlot = '12:00 - 2:00';
    } else if (currentHour >= 14 && currentHour < 16) {
      selectedTimeSlot = '2:00 - 4:00';
    } else if (currentHour >= 16 && currentHour < 18) {
      selectedTimeSlot = '4:00 - 6:00';
    } else if (currentHour >= 18 && currentHour < 20) {
      selectedTimeSlot = '6:00 - 8:00';
    } else {
      selectedTimeSlot = null;
    }

    if (isTest) {
      selectedTimeSlot = '12:00 - 2:00';
    }

    return selectedTimeSlot;
  }
}
