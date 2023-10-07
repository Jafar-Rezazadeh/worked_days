import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/view/tabs/worked_days_list/worked_days_list.dart';

class WorkedDaysPageController extends StatefulWidget {
  const WorkedDaysPageController({super.key});

  @override
  State<WorkedDaysPageController> createState() => _WorkedDaysPageControllerState();
}

class _WorkedDaysPageControllerState extends State<WorkedDaysPageController> {
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
    return WorkedDaysListPage(
      context: context,
      loadedStableState: loadedStableState,
      currentDateTime: currentDateTime,
      listOfCurrentWorkedDays: _getCurrentSelectedDateWorkedDays(),
      onCureentDateTimeChanged: (value) {
        setState(() {
          currentDateTime = value;
        });
      },
    );
  }

  _getCurrentSelectedDateWorkedDays() {
    return loadedStableState.workedDays
        .where(
          (element) =>
              element.dateTime.toJalali().month == currentDateTime.month &&
              element.dateTime.toJalali().year == currentDateTime.year,
        )
        .toList();
  }
}
