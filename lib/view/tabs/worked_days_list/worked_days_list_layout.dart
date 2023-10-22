import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/worked_day_model.dart';
import 'package:worked_days/view/tabs/worked_days_list/widgets/month_selector.dart';
import 'package:worked_days/view/tabs/worked_days_list/widgets/salary_calc.dart';
import 'package:worked_days/view/tabs/worked_days_list/widgets/worked_days_table.dart';

class WorkedDaysListPage extends StatelessWidget {
  final ValueChanged<Jalali> onCurrentMonthChanged;
  final List<WorkDayModel> listOfCurrentWorkedDays;
  final BuildContext context;
  final Jalali currentMonth;
  final LoadedStableState loadedStableState;
  const WorkedDaysListPage({
    super.key,
    required this.onCurrentMonthChanged,
    required this.listOfCurrentWorkedDays,
    required this.currentMonth,
    required this.context,
    required this.loadedStableState,
  });

  //Todo: tear down this tab ti simple widgets

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthSelectorWidget(
          onCurrentMonthChanged: onCurrentMonthChanged,
          currentMonth: currentMonth,
        ),
        WorkedDaysTableWidget(
          listOfCurrentWorkedDays: listOfCurrentWorkedDays,
          context: context,
          loadedStableState: loadedStableState,
        ),
        SalaryCalcWidget(
          loadedStableState: loadedStableState,
          currentMonth: currentMonth,
          listOfCurrentWorkedDays: listOfCurrentWorkedDays,
        ),
      ],
    );
  }
}
