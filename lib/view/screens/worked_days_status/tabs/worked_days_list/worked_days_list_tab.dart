import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/cubit/main_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/worked_day_model.dart';
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
  late List<WorkDayModel> listOfCurrentWorkedDays;
  Jalali currentMonth = Jalali.now();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  _getState() {
    mainCubit = BlocProvider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;

      workedDaysTabController = WorkedDaysTabController(
        loadedStableState: loadedStableState,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    listOfCurrentWorkedDays = workedDaysTabController.getCurrentSelectedDateWorkedDays(
      currentDateTime: currentMonth,
    );
    return Column(
      children: [
        MonthSelectorWidget(
          onCurrentMonthChanged: (value) => setState(() => currentMonth = value),
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
