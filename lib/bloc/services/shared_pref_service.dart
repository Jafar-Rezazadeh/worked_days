import 'package:shared_preferences/shared_preferences.dart';
import 'package:worked_days/ui/extentions/to_persian_period.dart';
import 'package:worked_days/data/entities/notification_pref_model.dart';
import 'package:worked_days/data/entities/prefs_keys.dart';

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
          notificationPrefModel.notificationPeriod!.toPersianPeriod);
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

  static Future<int> getSalaryAmountPref() async {
    try {
      final prefs = await SharedPreferencesService().getPrefs();
      int salaryAmount = prefs.getInt(PrefNames.salaryAmount.name) ?? 1;
      return salaryAmount;
    } catch (e) {
      return 1;
    }
  }
}
