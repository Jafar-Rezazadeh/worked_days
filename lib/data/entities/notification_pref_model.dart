import 'package:flutter/material.dart';

class NotificationPrefModel {
  final bool? notificationIsEnabled;
  final String? notificationPeriod;
  NotificationPrefModel({required this.notificationIsEnabled, required this.notificationPeriod});

  TimeOfDay? toTimeOfDay() {
    notificationPeriod;
    if (notificationPeriod == null) {
      return null;
    } else {
      return const TimeOfDay(hour: 00, minute: 00);
    }
  }
}
