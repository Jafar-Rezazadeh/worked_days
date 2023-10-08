import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/cubit/main_cubit_cubit.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/view/tabs/today_status/get_today_status.dart';
import 'package:worked_days/view/tabs/today_status/show_saved_status.dart';

class TodayStatusPageController extends StatefulWidget {
  const TodayStatusPageController({super.key});

  @override
  State<TodayStatusPageController> createState() => _TodayStatusPageControllerState();
}

class _TodayStatusPageControllerState extends State<TodayStatusPageController> {
  late LoadedStableState loadedStableState;
  late Size screenSize;
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
      screenSize = loadedStableState.screenSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    return doWeHaveTodayStatus()
        ? ShowSavedStatus(
            screenSize: screenSize,
            context: context,
            todayStatus: _getTodaySavedStatus(loadedStableState.workedDays),
            deleteTodayStatus: _deleteStatusHandler,
          )
        : GetTodayStatusPage(onSubmit: _handleSubmit);
  }

  _handleSubmit(WorkDayModel value) {
    mainCubit.insertWorkedDay(loadedStableState: loadedStableState, newWorkDayModel: value);
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

  _deleteStatusHandler(int id) {
    mainCubit.deleteWorkDay(loadedStableState: loadedStableState, id: id);
  }
}
