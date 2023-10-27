import 'package:flutter/material.dart';
import 'package:worked_days/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/cubit/main_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/view/screens/worked_days_status/tabs/worked_days_list/widgets/month_selector.dart';
import 'package:worked_days/view/screens/worked_days_status/tabs/worked_days_list/widgets/salary_calc.dart';
import 'package:worked_days/view/screens/worked_days_status/tabs/worked_days_list/widgets/worked_days_table.dart';

class WorkDaysListTab extends StatefulWidget {
  const WorkDaysListTab({super.key});

  @override
  State<WorkDaysListTab> createState() => _WorkDaysListLayoutState();
}

class _WorkDaysListLayoutState extends State<WorkDaysListTab> {
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  late WorkedDaysTabController workedDaysTabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    workedDaysTabController = WorkedDaysTabController(context: context, refreshView: refreshView);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthSelectorWidget(
          onCurrentMonthChanged: workedDaysTabController.handleCalenderChange,
          currentMonth: workedDaysTabController.currentMonth,
        ),
        WorkedDaysTableWidget(
          listOfCurrentWorkedDays: workedDaysTabController.listOfCurrentWorkedDays,
        ),
        SalaryCalcWidget(
          currentMonth: workedDaysTabController.currentMonth,
          listOfCurrentWorkedDays: workedDaysTabController.listOfCurrentWorkedDays,
        ),
      ],
    );
  }

  refreshView() {
    setState(() {});
  }
}
