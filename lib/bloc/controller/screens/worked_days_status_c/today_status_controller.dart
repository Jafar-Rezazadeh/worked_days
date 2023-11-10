import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/cubit/main_cubit.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/parts/get_today_status_/get_today_status.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/parts/show_today_status/show_saved_status.dart';

class TodayStatusTabController extends StatefulWidget {
  const TodayStatusTabController({super.key});

  @override
  State<TodayStatusTabController> createState() => _TodayStatusTabControllerState();
}

class _TodayStatusTabControllerState extends State<TodayStatusTabController> {
  late LoadedStableState loadedStableState;
  late MainCubit mainCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  void _getState() {
    mainCubit = Provider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return doWeHaveTodayStatus()
        ? ShowSavedStatus(
            context: context,
            todayStatus: _getTodaySavedStatus(loadedStableState.workedDays),
            deleteTodayStatus: _deleteTodayStatus,
          )
        : GetTodayStatus(onSubmit: _handleSubmit);
  }

  _handleSubmit(WorkDayModel value) {
    mainCubit.insertWorkedDay(loadedStableState: loadedStableState, newWorkDayModel: value);
    //
  }

  bool doWeHaveTodayStatus() {
    if (loadedStableState.workedDays.isNotEmpty) {
      return _isTodayStatusSaved(loadedStableState.workedDays);
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

  WorkDayModel _getTodaySavedStatus(List<WorkDayModel> workedDays) {
    return workedDays.firstWhere((element) =>
        element.dateTime.toJalali().distanceTo(DateTime.now().toJalali()).days.inDays == 0);
  }

  _deleteTodayStatus(int id) {
    mainCubit.deleteWorkDay(loadedStableState: loadedStableState, id: id);
  }
}
