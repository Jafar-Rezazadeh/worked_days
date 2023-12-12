import 'package:flutter/material.dart';

class WorkDay {
  final int id;
  final String title;
  final String? shortDescription;
  final DateTime date;
  final TimeOfDay? inTime;
  final TimeOfDay? outTime;
  final bool isWorkDay;
  final bool isDayOff;
  final bool isPublicHoliday;

  WorkDay({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.date,
    required this.inTime,
    required this.outTime,
    required this.isWorkDay,
    required this.isDayOff,
    required this.isPublicHoliday,
  });
}
