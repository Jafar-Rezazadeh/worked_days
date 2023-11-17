import 'package:flutter_animate/flutter_animate.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/cubit/main_cubit.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';

class TodayStatusTabController {
  late LoadedStableState _loadedStableState;
  late MainCubit _mainCubit;

  set setLoadedStableState(LoadedStableState loadedStableState) {
    _loadedStableState = loadedStableState;
  }

  set setMainCubit(MainCubit mainCubit) {
    _mainCubit = mainCubit;
  }

  handleSubmit(WorkDayModel value) {
    _mainCubit.insertWorkedDay(loadedStableState: _loadedStableState, newWorkDayModel: value);
    //
  }

  bool doWeHaveTodayStatus() {
    if (_loadedStableState.workedDays.isNotEmpty) {
      return _isTodayStatusSaved(_loadedStableState.workedDays);
    } else {
      return false;
    }
  }

  bool _isTodayStatusSaved(List<WorkDayModel> workedDays) {
    return workedDays
        .where((element) =>
            element.dateTime.toJalali().distanceTo(DateTime.now().toJalali()).days.inDays == 0)
        .isNotEmpty;
  }

  WorkDayModel getTodaySavedStatus(List<WorkDayModel> workedDays) {
    return workedDays.firstWhere((element) =>
        element.dateTime.toJalali().distanceTo(DateTime.now().toJalali()).days.inDays == 0);
  }

  deleteTodayStatus(int id) {
    _mainCubit.deleteWorkDay(loadedStableState: _loadedStableState, id: id);
  }
}
