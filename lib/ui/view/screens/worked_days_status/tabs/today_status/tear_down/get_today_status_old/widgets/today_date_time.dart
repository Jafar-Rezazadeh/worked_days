import 'package:flutter/material.dart';
import 'package:worked_days/ui/extentions/shamsi_formater.dart';

Widget todayDateTime({required double fontSize, required DateTime? currentDateTime}) {
  return Text(
    FormatJalaliTo.getTodayFullDateTime(currentDateTime),
    textDirection: TextDirection.rtl,
    style: TextStyle(
      fontSize: fontSize,
    ),
  );
}
