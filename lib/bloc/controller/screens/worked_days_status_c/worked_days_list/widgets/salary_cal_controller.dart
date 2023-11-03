import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/bloc/models/salary_model.dart';
import 'package:worked_days/bloc/models/worked_day_model.dart';

class SalaryCalcController {
  final WorkedDaysTabController workedDaysTabController;
  late SalaryModel? _storedSalary;
  SalaryCalcController({
    required this.workedDaysTabController,
  }) {
    _storedSalary = workedDaysTabController.currentMonthSalary;
  }

  SalaryModel? get storedSalary => _storedSalary;

  //

  String calculateThisMonthSalary() {
    int currentMonthLength = workedDaysTabController.currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay =
        workedDaysTabController.loadedStableState.settingsModel.salaryDefaultAmount /
            currentMonthLength;

    List<WorkDayModel> countedWorkDays = calcCountedWorkDays();
    // print(countedWorkDays.length);

    int countedWorkDaysSum = (salaryPerDay * countedWorkDays.length).toInt();

    return "${countedWorkDaysSum.toString().seRagham()} تومان";
  }

  List<WorkDayModel> calcCountedWorkDays() {
    return workedDaysTabController.listOfCurrentMonthWorkedDays
        .where(
          (element) => element.workDay == true || element.publicHoliday == true,
        )
        .toList();
  }

  List<WorkDayModel> calcDayOffs() {
    return workedDaysTabController.listOfCurrentMonthWorkedDays
        .where((element) => element.dayOff == true)
        .toList();
  }
}
