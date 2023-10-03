import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/extentions/my_extentions.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/notification_pref_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late MainCubit mainCubit;
  late Size screenSize;
  String? notificationPeriodInString;
  bool? isNotificationActive;

  @override
  void initState() {
    super.initState();
    mainCubit = Provider.of<MainCubit>(context, listen: false);

    screenSize = context.read<LoadedStableState>().screenSize;
    notificationPeriodInString =
        context.read<LoadedStableState>().notificationSettings.notificationPeriod!;
    isNotificationActive =
        context.read<LoadedStableState>().notificationSettings.notificationStatusPref!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallet.smoke,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorPallet.yaleBlue,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            alignment: Alignment.center,
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapHeaderToExpand: true,
          ),
          child: ListView(
            children: [
              _notificationCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationCard() {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: ExpandablePanel(
          header: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Text(
              "دریافت اعلان",
              style: TextStyle(fontSize: screenSize.width / 23),
            ),
          ),
          collapsed: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text.rich(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black54,
                fontSize: screenSize.width / 28,
              ),
              TextSpan(
                children: [
                  const TextSpan(text: "وضعیت: "),
                  TextSpan(
                    text: _convertNotificationStatusToText() ?? "نامعلوم",
                    style: TextStyle(
                      color: _convertNotificationStatusToColor() ?? Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          expanded: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                //? set periodic time for notification
                TextButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(20)),
                    shape: MaterialStatePropertyAll<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 1, color: ColorPallet.yaleBlue),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      if (value != null) {
                        notificationPeriodInString =
                            "${value.hour}:${value.minute} ${value.period.name}".toPersionPeriod;
                        //? main state
                        mainCubit.setNotificationSettings(
                          loadedStableState: context.read<LoadedStableState>(),
                          nS: NotificationPrefModel(
                            notificationStatusPref: isNotificationActive,
                            notificationPeriod: notificationPeriodInString,
                          ),
                        );
                        //? UI
                        setState(() {});
                      }
                    });
                  },
                  child: Text(
                    notificationPeriodInString ?? "یک زمان انتخاب کن",
                    style: TextStyle(
                      fontSize: screenSize.width / 23,
                      color: ColorPallet.yaleBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //? on/off notification
                ElevatedButton(
                  onPressed: () {
                    //? main state
                    mainCubit.setNotificationSettings(
                      loadedStableState: context.read<LoadedStableState>(),
                      nS: NotificationPrefModel(
                        notificationStatusPref: isNotificationActive == true ? false : true,
                        notificationPeriod: notificationPeriodInString,
                      ),
                    );
                    //? UI
                    setState(() {
                      isNotificationActive = isNotificationActive == true ? false : true;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      isNotificationActive == false ? ColorPallet.green : ColorPallet.orange,
                    ),
                  ),
                  child: Text(
                    isNotificationActive == true ? "غیر فعال سازی" : "فعال سازی",
                    style: TextStyle(fontSize: screenSize.width / 25),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _convertNotificationStatusToText() {
    return isNotificationActive == true ? "فعال" : "غیر فعال";
  }

  Color? _convertNotificationStatusToColor() {
    return isNotificationActive == true ? ColorPallet.green : ColorPallet.orange;
  }
}
