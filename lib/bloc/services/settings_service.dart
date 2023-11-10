import 'package:worked_days/bloc/entities/notification_pref_model.dart';
import 'package:worked_days/bloc/services/notification_service.dart';
import 'package:worked_days/bloc/services/shared_pref_service.dart';

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
        NotificationService.createPeriodicNotification(notificationPrefModel.toTimeOfDay());
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

  static Future<int?> getSalary() async {
    int? salaryAmount = await SharedPreferencesService.getSalaryAmountPref();

    return salaryAmount;
  }

  static setSalaryAmount(int? salaryAmount) async {
    await SharedPreferencesService.setSalaryAmountPref(salaryAmount);
  }
}
