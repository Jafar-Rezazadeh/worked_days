import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

extension ConverterTimeOfDay on TimeOfDay {
  String get toStringFormat {
    TimeOfDay time = this;
    return '${_twoDigits(time.hour)}:${_twoDigits(time.minute)} ${time.period.name.toPersianPeriod}';
  }

  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}

extension ConverterString on String {
  TimeOfDay get toTimeOfDayFormat {
    //
    String timeString = this;

    List<String> splittedString = timeString.split(":");
    //
    TimeOfDay timeOfDay = TimeOfDay(
      hour: int.parse(splittedString.first),
      minute: int.parse(splittedString.last.extractNumber(toDigit: NumStrLanguage.English)),
    );

    return timeOfDay;
  }
}

extension ExtendedTimeOfday on String {
  String get toPersianPeriod {
    return toUpperCase().replaceAll("AM", "ق.ظ").replaceAll("PM", "ب.ظ");
  }
}
