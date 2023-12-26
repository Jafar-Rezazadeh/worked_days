import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/features/work_days/domain/entities/work_day_temp.dart';

import '../../../domain/entities/work_days.dart';
import 'tear_down/get_today_status.dart';
import 'tear_down/show_today_status.dart';

class TodayStatusLayout extends StatelessWidget {
  final List<WorkDay> listOfWorkDay;
  final WorkDayTemporary? workDayTemporary;

  const TodayStatusLayout({super.key, required this.listOfWorkDay, required this.workDayTemporary});

  @override
  Widget build(BuildContext context) {
    return _doWeHaveTodayStatus()
        ? ShowTodayStatus(
            context: context,
            todayStatus: _getTodaySavedStatus(),
          )
        : GetTodayStatus(
            workDayTemporary: workDayTemporary,
          );
  }

  bool _doWeHaveTodayStatus() {
    if (listOfWorkDay.isNotEmpty) {
      return _isTodayStatusSaved(listOfWorkDay);
    } else {
      return false;
    }
  }

  bool _isTodayStatusSaved(List<WorkDay> workedDays) {
    return workedDays
        .where((element) =>
            element.date.toJalali().distanceTo(DateTime.now().toJalali()).days.inDays == 0)
        .isNotEmpty;
  }

  WorkDay _getTodaySavedStatus() {
    return listOfWorkDay.firstWhere((element) =>
        element.date.toJalali().distanceTo(DateTime.now().toJalali()).days.inDays == 0);
  }
}
