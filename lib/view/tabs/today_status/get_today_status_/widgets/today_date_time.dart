import 'package:flutter/material.dart';
import 'package:worked_days/controller/shamsi_formater.dart';

Widget todayDateTime(double fontSize) {
  return Text(
    ShamsiFormatter.getTodayFullDateTime(null),
    textDirection: TextDirection.rtl,
    style: TextStyle(
      fontSize: fontSize,
    ),
  );
}
