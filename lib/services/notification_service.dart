import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/services/shared_preferences.dart';

class NotificationService {
  static initalize() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          importance: NotificationImportance.High,
          playSound: true,
          ledColor: Colors.white,
        )
      ],
    );

    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (isAllowed) {
          NotificationPrefModel? notificationPrefModel =
              await SharedPreferencesService.getShowNotificationsPref();

          // TimeOfDay timeOfDay =
          List<NotificationModel> listOfnotif =
              await AwesomeNotifications().listScheduledNotifications();
          print(listOfnotif.first.content!.id);
          if (_isNotAlreadyScheduled(listOfnotif)) {
            createPeriodicNotification(
                notificationPrefModel.toTimeOfDay() ?? const TimeOfDay(hour: 18, minute: 0));
          }
        }
      },
    );
  }

  static createPeriodicNotification(TimeOfDay timeOfDay) async {
    NotificationPrefModel? notificationPrefModel =
        await SharedPreferencesService.getShowNotificationsPref();
    await AwesomeNotifications().cancel(0);
    if (notificationPrefModel.notificationStatusPref != null &&
        notificationPrefModel.notificationStatusPref != false) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 0,
          channelKey: "basic_channel",
          body: "ثبت کردن وضعیت امروز یادت نره ${Emojis.symbols_red_exclamation_mark}",
          title: "امروز کار کردی؟ ",
          category: NotificationCategory.Reminder,
          wakeUpScreen: true,
          fullScreenIntent: true,
          notificationLayout: NotificationLayout.BigText,
        ),
        actionButtons: [
          NotificationActionButton(
            key: "ok",
            label: "باشه",
            actionType: ActionType.DismissAction,
          ),
        ],
        schedule: NotificationCalendar(
          hour: timeOfDay.hour,
          minute: timeOfDay.minute,
          second: 00,
          repeats: true,
          preciseAlarm: true,
        ),
      );
    }
  }

  static showSimpleNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: "basic_channel",
        body: "some text",
      ),
    );
  }

  static bool _isNotAlreadyScheduled(List<NotificationModel> listOfnotif) {
    int theScheduledPeriodicNotification =
        listOfnotif.lastIndexWhere((element) => element.content!.id == 0);
    if (theScheduledPeriodicNotification == -1) {
      return true;
    } else {
      return false;
    }
  }
}
