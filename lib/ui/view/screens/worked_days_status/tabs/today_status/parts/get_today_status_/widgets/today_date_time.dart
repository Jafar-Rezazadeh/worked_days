import 'package:flutter/material.dart';
import 'package:worked_days/bloc/services/shamsi_formater_service.dart';

Widget todayDateTime(double fontSize) {
  return Text(
    ShamsiFormatterService.getTodayFullDateTime(null),
    textDirection: TextDirection.rtl,
    style: TextStyle(
      fontSize: fontSize,
    ),
  );
}
