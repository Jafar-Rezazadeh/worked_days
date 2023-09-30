import 'package:flutter/material.dart';

class NotificationPrefModel {
  final bool? notificationStatusPref;
  final String? notificationPeriod;
  NotificationPrefModel({required this.notificationStatusPref, required this.notificationPeriod});

  TimeOfDay? toTimeOfDay() {
    notificationPeriod;
    if (notificationPeriod == null) {
      return null;
    } else {
      return const TimeOfDay(hour: 00, minute: 00);
    }
  }
}
