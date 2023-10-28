import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/models/worked_day_model.dart';

class WorkedDaysTabController {
  late LoadedStableState _loadedStableState;
  late List<WorkDayModel> _listOfCurrentMonthWorkedDays;
  late Jalali _currentMonth;

  // getter
  LoadedStableState get loadedStableState => _loadedStableState;
  List<WorkDayModel> get listOfCurrentMonthWorkedDays => _listOfCurrentMonthWorkedDays;
  Jalali get currentMonth => _currentMonth;

  // setter

  set setLoadedStableState(LoadedStableState loadedStableState) {
    _loadedStableState = loadedStableState;
  }

  updateListOfCurrentMonthWorkedDays() {
    _listOfCurrentMonthWorkedDays = getCurrentSelectedDateWorkedDays();
  }

  set setCurrentMonth(Jalali value) {
    _currentMonth = value;
  }

  List<WorkDayModel> getCurrentSelectedDateWorkedDays() {
    return _loadedStableState.workedDays
        .where(
          (element) =>
              element.dateTime.toJalali().month == _currentMonth.month &&
              element.dateTime.toJalali().year == _currentMonth.year,
        )
        .toList();
  }
}
