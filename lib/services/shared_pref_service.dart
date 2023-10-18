import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/extentions/my_extentions.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/prefs_keys.dart';

class SharedPreferencesService {
  Future<SharedPreferences> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<NotificationPrefModel> getNotificationPref() async {
    final prefs = await SharedPreferencesService().getPrefs();

    bool? notificationStatusPref = prefs.getBool(PrefNames.showNotification.name);
    String? notificationPeriodPref = prefs.getString(PrefNames.notificationPeriod.name);

    return NotificationPrefModel(
      notificationIsEnabled: notificationStatusPref,
      notificationPeriod: notificationPeriodPref,
    );
  }

  static setNotificationPref(NotificationPrefModel notificationPrefModel) async {
    final prefs = await SharedPreferencesService().getPrefs();

    if (notificationPrefModel.notificationIsEnabled != null) {
      prefs.setBool(PrefNames.showNotification.name, notificationPrefModel.notificationIsEnabled!);
    }
    if (_isNotificationPeriodSet(notificationPrefModel)) {
      prefs.setString(PrefNames.notificationPeriod.name,
          notificationPrefModel.notificationPeriod!.toPersionPeriod);
    }
  }

  static bool _isNotificationPeriodSet(notificationPrefModel) {
    return notificationPrefModel.notificationPeriod != null;
  }

  static setSalaryAmountPref(int? salaryAmount) async {
    final prefs = await SharedPreferencesService().getPrefs();

    if (salaryAmount != null) {
      prefs.setInt(PrefNames.salaryAmount.name, salaryAmount);
    }
  }

  static getSalaryAmountPref() async {
    final prefs = await SharedPreferencesService().getPrefs();

    return prefs.getInt(PrefNames.salaryAmount.name);
  }
}
