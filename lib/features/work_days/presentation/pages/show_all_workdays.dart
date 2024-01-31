import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../salary/presentation/salary_main_widget.dart';
import '../../domain/entities/work_days.dart';
import '../widgets/list_workdays.dart';
import '../widgets/month_selector_workdays.dart';
import '../widgets/unknow_days/unknown_days_workdays.dart';

class ShowAllWorkDays extends StatefulWidget {
  final List<WorkDay> listOfWorkDays;
  const ShowAllWorkDays({super.key, required this.listOfWorkDays});

  @override
  State<ShowAllWorkDays> createState() => _ShowAllWorkDaysState();
}

class _ShowAllWorkDaysState extends State<ShowAllWorkDays> {
  Jalali currentDate = Jalali.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MonthSelectorWorkDays(
          currentDate: currentDate,
          onCurrentDateChanged: (value) => setState(() => currentDate = value),
        ),
        UnknownDaysWorkDays(
          currentDate: currentDate,
          listOfWorkDays: widget.listOfWorkDays,
        ),
        ListWorkDays(
          currentDate: currentDate,
          currentMonthWorkDays: _currentMonthWorkDays(),
        ),
        SalaryMainWidget(
          currentMonth: currentDate,
          listOfCurrentMonthWorkDay: _currentMonthWorkDays(),
        )
      ],
    );
  }

  List<WorkDay> _currentMonthWorkDays() {
    try {
      List<WorkDay> result = widget.listOfWorkDays
          .where(
            (element) =>
                element.date.toJalali().month == currentDate.month &&
                element.date.toJalali().year == currentDate.year,
          )
          .toList();

      result.sort((a, b) => a.date.compareTo(b.date));
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
