import 'package:flutter/foundation.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/cubit/main_cubit.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/data/entities/salary_model.dart';
import 'package:worked_days/data/entities/worked_day_model.dart';

class WorkedDaysTabController {
  late LoadedStableState _loadedStableState;
  late List<WorkDayModel> _listOfCurrentMonthWorkedDays;
  late SalaryModel? _currentMonthSalary;
  late Jalali _currentMonth;
  final MainCubit mainCubit;
  WorkedDaysTabController({required this.mainCubit});

  // getter
  LoadedStableState get loadedStableState => _loadedStableState;
  List<WorkDayModel> get listOfCurrentMonthWorkedDays => _listOfCurrentMonthWorkedDays;
  SalaryModel? get currentMonthSalary => _currentMonthSalary;
  Jalali get currentMonth => _currentMonth;

  // setter

  set setLoadedStableState(LoadedStableState loadedStableState) {
    _loadedStableState = loadedStableState;
  }

  updateDataToCurrentSelectedMonth() {
    _listOfCurrentMonthWorkedDays = getCurrentSelectedDateWorkedDays();
    _currentMonthSalary = getCurrentSelectedSalary();
  }

  set setCurrentMonth(Jalali value) {
    _currentMonth = value;
  }

  List<WorkDayModel> getCurrentSelectedDateWorkedDays() {
    try {
      return _loadedStableState.workedDays
          .where(
            (element) =>
                element.dateTime.toJalali().month == _currentMonth.month &&
                element.dateTime.toJalali().year == _currentMonth.year,
          )
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  SalaryModel? getCurrentSelectedSalary() {
    try {
      return _loadedStableState.salaries.singleWhere(
        (element) =>
            element.dateTime.toJalali().month == _currentMonth.month &&
            element.dateTime.toJalali().year == _currentMonth.year,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
