import 'package:flutter/material.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/salary_model.dart';
import 'package:worked_days/services/notification_service.dart';
import 'package:worked_days/services/shared_pref_service.dart';

class SettingsService {
  static Future<NotificationPrefModel> getNotificationStatus() async {
    NotificationPrefModel notificationPrefModel =
        await SharedPreferencesService.getNotificationPref();

    return notificationPrefModel;
  }

  static setNotificationStatus({required NotificationPrefModel notificationPrefModel}) async {
    await SharedPreferencesService.setNotificationPref(notificationPrefModel);

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

  static bool _isNotificationActive(NotificationPrefModel notificationPrefModel) {
    return notificationPrefModel.notificationIsEnabled == true;
  }

  static bool _isNotificationPeriodSet(notificationPrefModel) {
    return notificationPrefModel.notificationPeriod != null;
  }

  static getSalary() async {
    int? salaryAmount = await SharedPreferencesService.getSalaryAmountPref();

    return SalaryModel(salaryAmount: salaryAmount);
  }

  static setSalaryAmount(int? salaryAmount) async {
    await SharedPreferencesService.setSalaryAmountPref(salaryAmount);
  }
}
