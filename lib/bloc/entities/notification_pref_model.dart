import 'package:flutter/material.dart';

class NotificationPrefModel {
  final bool? notificationIsEnabled;
  final String? notificationPeriod;
  NotificationPrefModel({required this.notificationIsEnabled, required this.notificationPeriod});

  TimeOfDay toTimeOfDay() {
    if (notificationPeriod == null) {
      return const TimeOfDay(hour: 18, minute: 0);
    } else {
      return TimeOfDay(
        hour: int.parse(notificationPeriod!.split(':').first),
        minute: int.parse(notificationPeriod!.split(':')[1].split(" ").first),
      );
    }
  }
}
