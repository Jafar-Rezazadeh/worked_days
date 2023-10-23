import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:provider/provider.dart';
import 'package:worked_days/cubit/main_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/extentions/to_persian_period.dart';
import 'package:worked_days/models/color_schema.dart';
import 'package:worked_days/models/notification_pref_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  final TextEditingController salaryTextEditingController = TextEditingController();

  String? notificationPeriodInString;
  bool? isNotificationActive;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  _getState() {
    mainCubit = Provider.of<MainCubit>(context, listen: true);

    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;

      notificationPeriodInString = loadedStableState.notificationSettings.notificationPeriod ?? "";
      isNotificationActive = loadedStableState.notificationSettings.notificationIsEnabled!;
      salaryTextEditingController.text =
          loadedStableState.settingsModel.salaryModel.salaryAmount != null
              ? loadedStableState.settingsModel.salaryModel.salaryAmount.toString().seRagham()
              : "میزان حقوق را وارد کنید";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        backgroundColor: ColorPallet.smoke,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorPallet.yaleBlue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue),
            foregroundColor: MaterialStatePropertyAll<Color>(ColorPallet.smoke),
            textStyle: MaterialStatePropertyAll<TextStyle>(
              TextStyle(fontSize: 20.sp, fontFamily: "Vazir"),
            ),
            minimumSize: MaterialStatePropertyAll<Size>(Size(0.9.sw, 50)),
            shape: const MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
            ),
          ),
          onPressed: () => _submit(),
          child: const Text("ذخیره"),
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
                _notificationSetting(),
                _salaryCalculationsSettings(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _expandableCardModel(
      {required String header, required Widget collapsed, required Widget expanded}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ExpandablePanel(
          header: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Text(header, style: TextStyle(fontSize: 20.sp)),
          ),
          collapsed: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: collapsed,
          ),
          expanded: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: expanded,
          ),
        ),
      ),
    );
  }

  Widget _notificationSetting() {
    return _expandableCardModel(
      header: "دریافت اعلان",
      collapsed: Text.rich(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.black54, fontSize: 15.sp),
        TextSpan(
          children: [
            const TextSpan(text: "وضعیت: "),
            TextSpan(
              text: _convertNotificationStatusToText() ?? "نامعلوم",
              style: TextStyle(color: _convertNotificationStatusToColor() ?? Colors.black),
            ),
          ],
        ),
      ),
      expanded: Column(
        children: [
          _setPeriodicNotificationTime(),
          const SizedBox(height: 20),
          _activateOrDeactivateNotification(),
        ],
      ),
    );
  }

  String? _convertNotificationStatusToText() {
    return isNotificationActive == true ? "فعال" : "غیر فعال";
  }

  Color? _convertNotificationStatusToColor() {
    return isNotificationActive == true ? ColorPallet.green : ColorPallet.orange;
  }

  Widget _setPeriodicNotificationTime() {
    return TextButton(
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
            mainCubit.setNotificationSettings(
              loadedStableState: loadedStableState,
              nS: NotificationPrefModel(
                notificationIsEnabled: isNotificationActive,
                notificationPeriod:
                    "${value.hour}:${value.minute} ${value.period.name}".toPersianPeriod,
              ),
            );
          }
        });
      },
      child: Text(
        notificationPeriodInString ?? "یک زمان انتخاب کن",
        style: TextStyle(
          fontSize: 18.sp,
          color: ColorPallet.yaleBlue,
        ),
      ),
    );
  }

  Widget _activateOrDeactivateNotification() {
    return ElevatedButton(
      onPressed: () {
        mainCubit.setNotificationSettings(
          loadedStableState: loadedStableState,
          nS: NotificationPrefModel(
            notificationIsEnabled: isNotificationActive == true ? false : true,
            notificationPeriod: notificationPeriodInString,
          ),
        );
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(
          isNotificationActive == false ? ColorPallet.green : ColorPallet.orange,
        ),
      ),
      child: Text(
        isNotificationActive == true ? "غیر فعال سازی" : "فعال سازی",
        style: TextStyle(fontSize: 13.sp),
      ),
    );
  }

  Widget _salaryCalculationsSettings() {
    return _expandableCardModel(
      header: "حقوق",
      collapsed: Container(),
      expanded: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("حقوق ماهیانه"),
          const SizedBox(height: 10),
          //? salary input
          TextField(
            onTap: () => salaryTextEditingController.clear(),
            controller: salaryTextEditingController,
            onChanged: (value) =>
                salaryTextEditingController.text = value.seRagham().toEnglishDigit(),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]'))],
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: OutlineInputBorder(),
            ),
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "محاسبه بر اساس روز های کاری",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 12.sp,
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  _submit() async {
    if (salaryTextEditingController.text.isNotEmpty) {
      await mainCubit.setSalaryAmount(
        loadedStableState: loadedStableState,
        salaryAmount: int.parse(
          salaryTextEditingController.text.extractNumber(toDigit: NumStrLanguage.English),
        ),
      );
    }

    if (mounted) Navigator.pop(context);
  }
}
