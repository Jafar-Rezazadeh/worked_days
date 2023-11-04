import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/data/entities/salary_model.dart';
import 'package:worked_days/data/entities/worked_day_model.dart';

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

  int calculateThisMonthSalary(int? salary) {
    salary ??= workedDaysTabController.loadedStableState.settingsModel.salaryDefaultAmount;

    int currentMonthLength = workedDaysTabController.currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay = salary / currentMonthLength;

    List<WorkDayModel> countedWorkDays = calcCountedWorkDays();
    // print(countedWorkDays.length);

    int countedWorkDaysSum = (salaryPerDay * countedWorkDays.length).toInt();

    return countedWorkDaysSum;
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
