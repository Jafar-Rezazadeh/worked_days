import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/main_screen_controller.dart';
import 'package:worked_days/bloc/cubit/main_cubit.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/models/notification_pref_model.dart';
import 'package:worked_days/bloc/services/notification_service.dart';
import 'package:worked_days/bloc/services/settings_service.dart';
import 'package:worked_days/ui/view/screens/error/error_screen.dart';
import 'package:worked_days/ui/view/screens/loading/loading_screen.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/worked_days_status_screen.dart';

Future<void> main(List<String> args) async {
  await ScreenUtil.ensureScreenSize();
  runApp(const WorkedDays());

  NotificationService.initalize();
}

class WorkedDays extends StatefulWidget {
  const WorkedDays({super.key});

  @override
  State<WorkedDays> createState() => _WorkedDaysState();
}

class _WorkedDaysState extends State<WorkedDays> {
  MainScreenController mainScreenController = MainScreenController();

  @override
  void initState() {
    super.initState();
    showDoYouWannaGetNotificationOnceTime();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
        builder: (context, child) {
          //
          BlocProvider.of<MainCubit>(context).loadDataAndStartApp();

          return MaterialApp(
            theme: ThemeData(fontFamily: "Vazir"),
            home: BlocBuilder<MainCubit, MainCubitState>(
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
            ),
          );
        },
      ),
    );
  }

  void showDoYouWannaGetNotificationOnceTime() async {
    bool isNotificationShowStatusAlreadySet =
        await mainScreenController.isNotificationStatusSaved();

    if (context.mounted) {
      if (isNotificationShowStatusAlreadySet) {
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
                            notificationPeriod:
                                mainScreenController.notificationPrefModel.notificationPeriod ??
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
                        notificationPeriod:
                            mainScreenController.notificationPrefModel.notificationPeriod ??
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
