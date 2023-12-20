import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_schema.dart';
import '../../domain/entities/settings.dart';
import '../cubit/cubit/settings_cubit.dart';
import '../widgets/notification_settings_widget.dart';
import '../widgets/salary_calc_settings_widget.dart';

class SettingsLoadedPage extends StatefulWidget {
  final Settings settings;
  const SettingsLoadedPage({super.key, required this.settings});

  @override
  State<SettingsLoadedPage> createState() => _SettingsLoadedPageState();
}

class _SettingsLoadedPageState extends State<SettingsLoadedPage> {
  late bool isNotificationActive;
  late int salaryAmountContract;
  late TimeOfDay notificationPeriodTime;

  @override
  void initState() {
    super.initState();
    isNotificationActive = widget.settings.isNotificationActive;
    salaryAmountContract = widget.settings.salaryAmountContract;
    notificationPeriodTime = widget.settings.notificationPeriodTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ExpandableTheme(
            data: _expandableDataTheme(),
            child: Stack(
              children: [
                ListView(
                  children: [
                    NotificationSettingsWidget(
                      initialNotificationPeriodTime: notificationPeriodTime,
                      isActive: isNotificationActive,
                      onActivateChanged: (value) => isNotificationActive = value,
                      onNotificationTimeChanged: (value) {
                        notificationPeriodTime = value;
                      },
                    ),
                    SalaryCalcSettingsWidget(
                      initialSalary: salaryAmountContract,
                      onTextFieldValueChanged: (value) => salaryAmountContract = value,
                    ),
                  ],
                ),
                _submitWidget()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  ExpandableThemeData _expandableDataTheme() {
    return const ExpandableThemeData(
      alignment: Alignment.center,
      headerAlignment: ExpandablePanelHeaderAlignment.center,
      tapHeaderToExpand: true,
    );
  }

  Widget _submitWidget() {
    return Visibility(
      visible: MediaQuery.of(context).viewInsets.bottom == 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
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
          onPressed: () async {
            final settings = Settings(
              salaryAmountContract: salaryAmountContract,
              isNotificationActive: isNotificationActive,
              notificationPeriodTime: notificationPeriodTime,
            );

            final isInserted =
                await BlocProvider.of<SettingsCubit>(context).insertSettings(settings);

            if (mounted) Navigator.of(context).pop<bool>(isInserted);
          },
          child: const Text("ذخیره"),
        ),
      ),
    );
  }
}
