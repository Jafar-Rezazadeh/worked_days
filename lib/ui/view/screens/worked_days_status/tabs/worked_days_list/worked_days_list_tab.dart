import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_screen/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/bloc/cubit/main_cubit.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/tear_down/month_selector.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/tear_down/salary_calc/salary_calc.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/tear_down/unknonw_days/unknown_days.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/tear_down/worked_days_table.dart';

class WorkDaysListTab extends StatefulWidget {
  const WorkDaysListTab({super.key});

  @override
  State<WorkDaysListTab> createState() => _WorkDaysListLayoutState();
}

class _WorkDaysListLayoutState extends State<WorkDaysListTab> {
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  late WorkedDaysTabController workedDaysTabController;
  Jalali currentMonth = Jalali.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  void _getState() {
    mainCubit = BlocProvider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;
      workedDaysTabController = WorkedDaysTabController(mainCubit: mainCubit);
      workedDaysTabController.setCurrentMonth = currentMonth;
      workedDaysTabController.setLoadedStableState = loadedStableState;
      workedDaysTabController.updateDataToCurrentSelectedMonth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        MonthSelectorWidget(
          onCurrentMonthChanged: (value) => setState(() {
            workedDaysTabController.setCurrentMonth = value;
            workedDaysTabController.updateDataToCurrentSelectedMonth();
          }),
          currentMonth: workedDaysTabController.currentMonth,
        ),
        //
        UnknownDays(
          workedDaysTabController: workedDaysTabController,
        ),
        //
        WorkedDaysTableWidget(
          context: context,
          workedDaysTabController: workedDaysTabController,
        ),
        //
        SalaryCalcWidget(
          workedDaysTabController: workedDaysTabController,
        ),
      ],
    );
  }
}
