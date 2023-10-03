import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/services/settings_service.dart';
import 'package:worked_days/view/screens/loading_screen.dart';
import 'package:worked_days/view/screens/worked_days_status_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          return Provider.value(
            value: state,
            child: const WorkedDaysStatusScreen(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<void> _showAlertForNotifications() async {
    NotificationPrefModel? notificationPrefModel = await SettingsService.getShowNotificationsPref();

    bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (context.mounted) {
      if (notificationPrefModel.notificationStatusPref == null ||
          isNotificationAllowed == false && notificationPrefModel.notificationStatusPref != false) {
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
                        SettingsService.setNotificationPref(
                          notificationPrefModel: NotificationPrefModel(
                            notificationStatusPref: true,
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
                    SettingsService.setNotificationPref(
                      notificationPrefModel: NotificationPrefModel(
                        notificationStatusPref: false,
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
