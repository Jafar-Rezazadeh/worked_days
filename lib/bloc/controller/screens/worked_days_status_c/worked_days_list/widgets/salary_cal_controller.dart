import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/cubit/main_cubit_state.dart';
import 'package:worked_days/bloc/models/worked_day_model.dart';

class SalaryCalcController {
  final Jalali currentMonth;
  final LoadedStableState loadedStableState;
  final List<WorkDayModel> listOfCurrentWorkedDays;

  SalaryCalcController({
    required this.currentMonth,
    required this.loadedStableState,
    required this.listOfCurrentWorkedDays,
  });

  String calculateThisMonthSalary() {
    int currentMonthLength = currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay =
        loadedStableState.settingsModel.salaryModel.salaryAmount! / currentMonthLength;

    List<WorkDayModel> countedWorkDays = calcCountedWorkDays();
    // print(countedWorkDays.length);

    int countedWorkDaysSum = (salaryPerDay * countedWorkDays.length).toInt();

    return "${countedWorkDaysSum.toString().seRagham()} تومان";
  }

  List<WorkDayModel> calcCountedWorkDays() {
    return listOfCurrentWorkedDays
        .where(
          (element) => element.workDay == true || element.publicHoliday == true,
        )
        .toList();
  }

  List<WorkDayModel> calcDayOffs() {
    return listOfCurrentWorkedDays.where((element) => element.dayOff == true).toList();
  }
}
