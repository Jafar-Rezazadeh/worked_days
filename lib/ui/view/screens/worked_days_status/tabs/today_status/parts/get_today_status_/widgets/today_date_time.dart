import 'package:flutter/material.dart';
import 'package:worked_days/ui/extentions/shamsi_formater.dart';

Widget todayDateTime(double fontSize) {
  return Text(
    FormatJalaliTo.getTodayFullDateTime(null),
    textDirection: TextDirection.rtl,
    style: TextStyle(
      fontSize: fontSize,
    ),
  );
}
