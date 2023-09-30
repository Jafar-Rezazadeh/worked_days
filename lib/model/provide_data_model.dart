import 'package:flutter/material.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/services/db_provider.dart';
import 'package:worked_days/services/shared_preferences.dart';

class ProviderDataModel extends ChangeNotifier {
  final Size screenSize;
  final List<WorkDayModel> workedDays;
  NotificationPrefModel notificationSettings;

  ProviderDataModel({
    required this.screenSize,
    required this.workedDays,
    required this.notificationSettings,
  });

  insertWorkedDay(WorkDayModel workDayModel) async {
    workDayModel.id = await DataBaseHandler().insertWorkDay(workDayModel);
    workedDays.add(workDayModel);
    notifyListeners();
  }

  deletWorkDay(int id) async {
    await DataBaseHandler().deleteWorkDay(id);
    workedDays.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  setNotificationSettings(NotificationPrefModel nS) {
    notificationSettings = NotificationPrefModel(
      notificationStatusPref:
          nS.notificationStatusPref ?? notificationSettings.notificationStatusPref,
      notificationPeriod: nS.notificationPeriod ?? notificationSettings.notificationPeriod,
    );
    SharedPreferencesService.setShowNotificationPref(notificationPrefModel: nS);
    notifyListeners();
  }
}
