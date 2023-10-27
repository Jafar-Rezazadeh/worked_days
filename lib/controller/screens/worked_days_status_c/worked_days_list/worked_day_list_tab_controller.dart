import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/cubit/main_cubit.dart';

import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/worked_day_model.dart';

class WorkedDaysTabController extends ControllerMVC {
  final Function? refreshView;
  final BuildContext context;
  late MainCubit _mainCubit;
  late LoadedStableState _loadedStableState;
  late List<WorkDayModel> _listOfCurrentWorkedDays;
  Jalali _currentMonth = Jalali.now();

  LoadedStableState get loadedStableState => _loadedStableState;
  List<WorkDayModel> get listOfCurrentWorkedDays => _listOfCurrentWorkedDays;
  get currentMonth => _currentMonth;
  set setCurrentMonth(Jalali value) {
    _currentMonth = value;
  }

  WorkedDaysTabController({required this.context, this.refreshView}) {
    _mainCubit = BlocProvider.of<MainCubit>(context, listen: true);
    if (_mainCubit.state is LoadedStableState) {
      _loadedStableState = _mainCubit.state as LoadedStableState;

      setListOfCurrentWorkedDays();
    }
  }

  List<WorkDayModel> getCurrentSelectedDateWorkedDays() {
    return _loadedStableState.workedDays
        .where((element) =>
            element.dateTime.toJalali().month == _currentMonth.month &&
            element.dateTime.toJalali().year == _currentMonth.year)
        .toList();
  }

  void setListOfCurrentWorkedDays() {
    _listOfCurrentWorkedDays = getCurrentSelectedDateWorkedDays();
    if (refreshView != null) {
      refreshView!();
    }
  }

  handleCalenderChange(Jalali value) {
    _currentMonth = value;
    setListOfCurrentWorkedDays();
  }
}
