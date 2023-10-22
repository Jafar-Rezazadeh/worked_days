extension ExtendedTimeOfday on String {
  String get toPersianPeriod {
    return toUpperCase().replaceAll("AM", "ق.ظ").replaceAll("PM", "ب.ظ");
  }
}
