extension ExtendedTimeOfday on String {
  String get toPersionPeriod {
    return toUpperCase().replaceAll("AM", "ق.ظ").replaceAll("PM", "ب.ظ");
  }
}
