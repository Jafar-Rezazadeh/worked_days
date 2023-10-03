import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/extentions/my_extentions.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/prefs_keys.dart';
import 'package:worked_days/services/notification_service.dart';

class SettingsService {
  Future<SharedPreferences> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<NotificationPrefModel> getShowNotificationsPref() async {
    final prefs = await SettingsService().getPrefs();

    // await prefs.remove(PrefNames.showNotification.name);

    bool? notificationStatusPref = prefs.getBool(PrefNames.showNotification.name);
    String? notificationPeriodPref = prefs.getString(PrefNames.notificationPeriod.name);

    return NotificationPrefModel(
      notificationStatusPref: notificationStatusPref,
      notificationPeriod: notificationPeriodPref,
    );
  }

  static setNotificationPref({required NotificationPrefModel notificationPrefModel}) async {
    final prefs = await SettingsService().getPrefs();

    if (notificationPrefModel.notificationStatusPref != null) {
      prefs.setBool(PrefNames.showNotification.name, notificationPrefModel.notificationStatusPref!);
    }

    if (_isNotificationPeriodSet(notificationPrefModel)) {
      prefs.setString(PrefNames.notificationPeriod.name,
          notificationPrefModel.notificationPeriod!.toPersionPeriod);

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
