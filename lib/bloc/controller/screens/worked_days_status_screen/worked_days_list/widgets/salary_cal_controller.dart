import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_screen/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/bloc/entities/salary_model.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';

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
    salary ??= workedDaysTabController.loadedStableState.settingsModel.salaryDefaultAmount ?? 0;

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

  insertSalary({required SalaryCalcController salaryCalcController, required String paidSalary}) {
    SalaryModel salaryModel = SalaryModel(
      id: salaryCalcController.storedSalary?.id ?? 0,
      salaryAmount: _extractNumberFromString(paidSalary),
      dateTime: salaryCalcController.workedDaysTabController.currentMonth.toDateTime(),
    );

    salaryCalcController.workedDaysTabController.mainCubit.insertSalary(
      loadedStableState: salaryCalcController.workedDaysTabController.loadedStableState,
      salaryModel: salaryModel,
    );
  }

  int _extractNumberFromString(String paidSalary) {
    return int.parse(
      paidSalary.extractNumber(toDigit: NumStrLanguage.English),
    );
  }

  bool ifSalaryStored() {
    return storedSalary != null ? true : false;
  }

  bool ifSalaryAmountIsSet() {
    return workedDaysTabController.loadedStableState.settingsModel.salaryDefaultAmount != null;
  }
}
