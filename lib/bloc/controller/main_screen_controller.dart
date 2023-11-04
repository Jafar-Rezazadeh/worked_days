import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:worked_days/data/entities/notification_pref_model.dart';
import 'package:worked_days/bloc/services/settings_service.dart';

class MainScreenController {
  NotificationPrefModel? _notificationPrefModel;

  get notificationPrefModel => _notificationPrefModel;

  MainScreenController() {
    getNotificationStatus();
  }

  getNotificationStatus() async {
    _notificationPrefModel = await SettingsService.getNotificationStatus();
  }

  Future<bool> isNotificationStatusSaved() async {
    bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (_notificationPrefModel!.notificationIsEnabled == null ||
        isNotificationAllowed == false && _notificationPrefModel!.notificationIsEnabled != false) {
      return true;
    } else {
      return false;
    }
  }
}
