import 'package:shamsi_date/shamsi_date.dart';

import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/worked_day_model.dart';

class WorkedDaysTabController {
  final LoadedStableState loadedStableState;

  WorkedDaysTabController({required this.loadedStableState});

  List<WorkDayModel> getCurrentSelectedDateWorkedDays({required Jalali currentDateTime}) {
    return loadedStableState.workedDays
        .where((element) =>
            element.dateTime.toJalali().month == currentDateTime.month &&
            element.dateTime.toJalali().year == currentDateTime.year)
        .toList();
  }
}
