import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  late int workDayTimeContractInHours;
  late TimeOfDay notificationPeriodTime;

  @override
  void initState() {
    super.initState();
    isNotificationActive = widget.settings.isNotificationActive;
    salaryAmountContract = widget.settings.salaryAmountContract;
    workDayTimeContractInHours = widget.settings.workDayTimeContractAsHours;
    notificationPeriodTime = widget.settings.notificationPeriodTime;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          final settings = Settings(
            workDayTimeContractAsHours: workDayTimeContractInHours,
            salaryAmountContract: salaryAmountContract,
            isNotificationActive: isNotificationActive,
            notificationPeriodTime: notificationPeriodTime,
          );
          await BlocProvider.of<SettingsCubit>(context).insertSettings(settings);
        }
      },
      child: Scaffold(
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
                        workDayTimeContractInHours: workDayTimeContractInHours,
                        salaryContract: salaryAmountContract,
                        onContractsEnter: ({salaryContractAmount_, workDayTimeContractInHours_}) {
                          salaryAmountContract = salaryContractAmount_ ?? salaryAmountContract;
                          workDayTimeContractInHours =
                              workDayTimeContractInHours_ ?? workDayTimeContractInHours;
                          // print([salaryContractAmount_, workDayTimeContractInHours_]);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  ExpandableThemeData _expandableDataTheme() {
    return const ExpandableThemeData(
      alignment: Alignment.center,
      headerAlignment: ExpandablePanelHeaderAlignment.center,
      tapHeaderToExpand: true,
    );
  }
}
