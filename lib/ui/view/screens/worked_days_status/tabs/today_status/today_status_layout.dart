import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_screen/today_status_controller.dart';
import 'package:worked_days/bloc/cubit/main_cubit.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/get_today_status_new/get_today_status.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/today_status/tear_down/show_today_status/show_saved_status.dart';

class TodayStatusLayout extends StatefulWidget {
  const TodayStatusLayout({super.key});

  @override
  State<TodayStatusLayout> createState() => _TodayStatusLayoutState();
}

class _TodayStatusLayoutState extends State<TodayStatusLayout> {
  late MainCubit mainCubit;
  late LoadedStableState loadedStableState;
  late TodayStatusTabController todayStatusTabController = TodayStatusTabController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getState();
  }

  void _getState() {
    mainCubit = Provider.of<MainCubit>(context, listen: true);
    if (mainCubit.state is LoadedStableState) {
      loadedStableState = mainCubit.state as LoadedStableState;

      todayStatusTabController.setMainCubit = mainCubit;
      todayStatusTabController.setLoadedStableState = loadedStableState;
    }
  }

  @override
  Widget build(BuildContext context) {
    return todayStatusTabController.doWeHaveTodayStatus()
        ? ShowSavedStatus(
            context: context,
            todayStatus: todayStatusTabController.getTodaySavedStatus(loadedStableState.workedDays),
            deleteTodayStatus: todayStatusTabController.deleteTodayStatus,
          )
        : GetTodayStatusNewUI(
            onSubmit: todayStatusTabController.handleSubmit,
          );
  }
}
