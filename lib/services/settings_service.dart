import 'package:flutter/material.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/services/notification_service.dart';
import 'package:worked_days/services/shared_pref_service.dart';

class SettingsService {
  static Future<NotificationPrefModel> getNotificationStatus() async {
    NotificationPrefModel notificationPrefModel =
        await SharedPreferencesService.getNotificationPref();

    return notificationPrefModel;
  }

  static setNotificationPref({required NotificationPrefModel notificationPrefModel}) async {
    SharedPreferencesService.setNotificationStatus(notificationPrefModel);

    if (_isNotificationPeriodSet(notificationPrefModel)) {
      if (_isNotificationActive(notificationPrefModel)) {
        NotificationService.createPeriodicNotification(
          TimeOfDay(
            hour: int.parse(notificationPrefModel.notificationPeriod!.split(':').first),
            minute:
                int.parse(notificationPrefModel.notificationPeriod!.split(':')[1].split(" ").first),
          ),
        );
      } else {
        NotificationService.cancelPeriodicNotifications();
      }
    }
  }

  static bool _isNotificationActive(notificationPrefModel) {
    return notificationPrefModel.notificationStatusPref == true;
  }

  static bool _isNotificationPeriodSet(notificationPrefModel) {
    return notificationPrefModel.notificationPeriod != null;
  }
}
