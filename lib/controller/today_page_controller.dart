import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/model/provide_data_model.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/view/page/today_status/show_saved_status.dart';
import 'package:worked_days/view/page/today_status/get_today_status.dart';

class TodayStatusPageController extends StatefulWidget {
  const TodayStatusPageController({super.key});

  @override
  State<TodayStatusPageController> createState() => _TodayStatusPageControllerState();
}

class _TodayStatusPageControllerState extends State<TodayStatusPageController> {
  late ProviderDataModel providerDataModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    providerDataModel = context.watch<ProviderDataModel>();

    return doWeHaveTodayStatus()
        ? ShowSavedStatus(
            context: context,
            todayStatus: _getTodaySavedStatus(providerDataModel.workedDays),
            deleteTodayStatus: _deleteStatusHandler,
          )
        : GetTodayStatusPage(
            onSubmit: _handleSubmit,
          );
  }

  _handleSubmit(WorkDayModel value) {
    providerDataModel.insertWorkedDay(value);
  }

  bool doWeHaveTodayStatus() {
    if (providerDataModel.workedDays.isNotEmpty) {
      return _isTodayStatusSaved(providerDataModel.workedDays);
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
    providerDataModel.deletWorkDay(id);
  }
}
