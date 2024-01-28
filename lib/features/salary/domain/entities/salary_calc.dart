import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/features/salary/domain/entities/salary.dart';

import '../../../work_days/domain/entities/work_days.dart';

class SalaryCalculationEntity {
  final Jalali currentMonth;
  final List<WorkDay> listOfCurrentMonthWorkDay;
  final List<SalaryEntity> salaries;
  final int salaryContract;

  SalaryCalculationEntity({
    required this.salaries,
    required this.currentMonth,
    required this.listOfCurrentMonthWorkDay,
    required this.salaryContract,
  }) {
    _calcCountedWorkDays();
    _calculateThisMonthSalary();
    _calcDayOffs();
    _getCurrentSelectedSalary();
  }

  int _dayOffs = 0;
  int _calcSalary = 0;
  int _workDays = 0;
  SalaryEntity? _currentSalary;

  int get dayOffs => _dayOffs;
  int get calculatedSalary => _calcSalary;
  int get workDays => _workDays;
  SalaryEntity? get currentSalary => _currentSalary;

  _calculateThisMonthSalary() {
    int currentMonthLength = currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay = salaryContract / currentMonthLength;

    // print(countedWorkDays.length);

    int countedWorkDaysSum = (salaryPerDay * _workDays).toInt();

    _calcSalary = countedWorkDaysSum;
  }

  _calcCountedWorkDays() {
    _workDays = listOfCurrentMonthWorkDay
        .where(
          (element) => element.isWorkDay == true || element.isPublicHoliday == true,
        )
        .toList()
        .length;
  }

  _calcDayOffs() {
    _dayOffs =
        listOfCurrentMonthWorkDay.where((element) => element.isDayOff == true).toList().length;
  }

  SalaryEntity? _getCurrentSelectedSalary() {
    try {
      _currentSalary = salaries.firstWhere(
        (element) =>
            element.dateTime.toJalali().month == currentMonth.month &&
            element.dateTime.toJalali().year == currentMonth.year,
      );
    } catch (e) {
      return null;
    }
    return null;
  }
}
