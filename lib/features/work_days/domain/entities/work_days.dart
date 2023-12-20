import 'package:flutter/material.dart';

class WorkDay {
  final int id;
  final String title;
  String? shortDescription;
  DateTime date;
  TimeOfDay? inTime;
  TimeOfDay? outTime;
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
