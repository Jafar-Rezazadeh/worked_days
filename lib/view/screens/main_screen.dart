import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worked_days/controller/today_page_controller.dart';
import 'package:worked_days/controller/worked_days_page_controller.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/notification_pref_model.dart';
import 'package:worked_days/model/provide_data_model.dart';
import 'package:worked_days/services/shared_preferences.dart';
import 'package:worked_days/view/screens/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

late ProviderDataModel providerDataModel;
late Size screenSize;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _showAlertForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    providerDataModel = context.watch<ProviderDataModel>();
    screenSize = providerDataModel.screenSize;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: ColorPallet.smoke,
          appBar: _appBar(),
          body: _tabView(),
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorPallet.yaleBlue,
      centerTitle: true,
      title: const Text(
        "Developed by Jafar.Rezazadeh ©",
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyle(
        fontSize: screenSize.width / 50,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ),
      ],
      bottom: _tabBar(),
    );
  }

  _tabBar() {
    return PreferredSize(
      preferredSize: Size(
        double.infinity,
        screenSize.height / 10,
      ),
      child: TabBar(
        indicatorColor: ColorPallet.orange,
        indicatorWeight: 4,
        tabs: [
          Tab(
            height: 50,
            child: Text(
              "وضعیت امروز",
              style: _tabTextStyle(),
            ),
          ),
          Tab(
            height: 50,
            child: Text(
              "لیست روز های کاری",
              style: _tabTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  _tabView() {
    return const TabBarView(
      children: [
        TodayStatusPageController(),
        WorkedDaysPageController(),
      ],
    );
  }

  _tabTextStyle() {
    return TextStyle(
      color: ColorPallet.smoke,
    );
  }

  Future<void> _showAlertForNotifications() async {
    NotificationPrefModel? notificationPrefModel =
        await SharedPreferencesService.getShowNotificationsPref();

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
                        SharedPreferencesService.setShowNotificationPref(
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
                    SharedPreferencesService.setShowNotificationPref(
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
