import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

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
  }

  static createPeriodicNotification(TimeOfDay timeOfDay) async {
    await cancelPeriodicNotifications();

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

  static cancelPeriodicNotifications() async {
    await AwesomeNotifications().cancel(0);
  }

  static Future<bool> isAlreadyScheduled() async {
    final listOfNotif = await AwesomeNotifications().listScheduledNotifications();
    int theScheduledPeriodicNotification =
        listOfNotif.lastIndexWhere((element) => element.content!.id == 0);
    if (theScheduledPeriodicNotification != -1) {
      return true;
    } else {
      return false;
    }
  }
}
