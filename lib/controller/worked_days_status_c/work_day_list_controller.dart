import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/view/screens/worked_days_status/tabs/work_days_list/worked_days_list_layout.dart';

class WorkedDaysTabController extends StatefulWidget {
  const WorkedDaysTabController({super.key});

  @override
  State<WorkedDaysTabController> createState() => _WorkedDaysTabControllerState();
}

class _WorkedDaysTabControllerState extends State<WorkedDaysTabController> {
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  Jalali currentDateTime = Jalali.now();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  _getState() {
    mainCubit = BlocProvider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WorkDaysListPage(
      context: context,
      loadedStableState: loadedStableState,
      currentMonth: currentDateTime,
      listOfCurrentWorkedDays: _getCurrentSelectedDateWorkedDays(),
      onCurrentMonthChanged: (value) => setState(() => currentDateTime = value),
    );
  }

  _getCurrentSelectedDateWorkedDays() {
    return loadedStableState.workedDays
        .where((element) =>
            element.dateTime.toJalali().month == currentDateTime.month &&
            element.dateTime.toJalali().year == currentDateTime.year)
        .toList();
  }
}
