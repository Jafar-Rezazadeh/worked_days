import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worked_days/cubit/main_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/notification_pref_model.dart';
import 'package:worked_days/services/settings_service.dart';
import 'package:worked_days/view/screens/error/error_screen.dart';
import 'package:worked_days/view/screens/loading/loading_screen.dart';
import 'package:worked_days/view/screens/worked_days_status/worked_days_status_screen.dart';

class MainScreenController extends StatefulWidget {
  const MainScreenController({super.key});

  @override
  State<MainScreenController> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenController> {
  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().loadDataAndStartApp();
    _showAlertForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingState) {
          return const LoadingScreen();
        }
        if (state is LoadedStableState) {
          return const WorkedDaysStatusScreen();
        } else {
          return const ErrorScreen(errorMessage: "There is some error");
        }
      },
    );
  }

  Future<void> _showAlertForNotifications() async {
    NotificationPrefModel? notificationPrefModel = await SettingsService.getNotificationStatus();

    bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (context.mounted) {
      if (notificationPrefModel.notificationIsEnabled == null ||
          isNotificationAllowed == false && notificationPrefModel.notificationIsEnabled != false) {
        showDialog(
          context: context,
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: const Text("نمایش اعلان"),
              content: const Text("آیا میخواهید برای شما یادآوری شود؟"),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                //? showNotifications
                TextButton(
                  onPressed: () {
                    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
                      if (isAllowed) {
                        SettingsService.setNotificationStatus(
                          notificationPrefModel: NotificationPrefModel(
                            notificationIsEnabled: true,
                            notificationPeriod: notificationPrefModel.notificationPeriod ??
                                const TimeOfDay(hour: 18, minute: 0).format(context),
                          ),
                        );
                      } else {
                        AwesomeNotifications().requestPermissionToSendNotifications();
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("بله"),
                ),
                //? do not showNotifications
                TextButton(
                  onPressed: () {
                    SettingsService.setNotificationStatus(
                      notificationPrefModel: NotificationPrefModel(
                        notificationIsEnabled: false,
                        notificationPeriod: notificationPrefModel.notificationPeriod ??
                            const TimeOfDay(hour: 18, minute: 0).format(context),
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: const Text("خیر"),
                )
              ],
            ),
          ),
        );
      }
    }
  }
}
