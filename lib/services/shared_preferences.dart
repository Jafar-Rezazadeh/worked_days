import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/extentions/my_extentions.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/prefs_keys.dart';
import 'package:worked_days/services/notification_service.dart';

class SharedPreferencesService {
  Future<SharedPreferences> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<NotificationPrefModel> getShowNotificationsPref() async {
    final prefs = await SharedPreferencesService().getPrefs();

    // await prefs.remove(PrefNames.showNotification.name);

    bool? notificationStatusPref = prefs.getBool(PrefNames.showNotification.name);
    String? notificationPeriodPref = prefs.getString(PrefNames.notificationPeriod.name);

    return NotificationPrefModel(
      notificationStatusPref: notificationStatusPref,
      notificationPeriod: notificationPeriodPref,
    );
  }

  static setShowNotificationPref({required NotificationPrefModel notificationPrefModel}) async {
    final prefs = await SharedPreferencesService().getPrefs();

    if (notificationPrefModel.notificationStatusPref != null) {
      prefs.setBool(PrefNames.showNotification.name, notificationPrefModel.notificationStatusPref!);
    }

    if (notificationPrefModel.notificationPeriod != null) {
      prefs.setString(PrefNames.notificationPeriod.name,
          notificationPrefModel.notificationPeriod!.toPersionPeriod);
      if (kDebugMode) {
        print(notificationPrefModel.notificationPeriod!.split(':').first);
        print(notificationPrefModel.notificationPeriod!.split(':')[1].split(" ").first);
      }

      NotificationService.createPeriodicNotification(
        TimeOfDay(
          hour: int.parse(notificationPrefModel.notificationPeriod!.split(':').first),
          minute:
              int.parse(notificationPrefModel.notificationPeriod!.split(':')[1].split(" ").first),
        ),
      );
    }
  }
}
