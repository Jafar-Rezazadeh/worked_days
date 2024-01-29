import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/features/salary/domain/entities/salary.dart';

import '../../../work_days/domain/entities/work_days.dart';

class SalaryCalculationEntity {
  final int eachDayTimeContract;
  final Jalali currentMonth;
  final List<WorkDay> listOfCurrentMonthWorkDay;
  final List<SalaryEntity> salaries;
  final int salaryContract;

  SalaryCalculationEntity({
    required this.salaries,
    required this.currentMonth,
    required this.listOfCurrentMonthWorkDay,
    required this.salaryContract,
    required this.eachDayTimeContract,
  }) {
    _calcCountedWorkDays();
    _getWorkDaysWorkTimeAsMinutes();
    _calculateThisMonthSalary();
    _calcDayOffs();
    _getCurrentSelectedSalary();
  }

  int _dayOffs = 0;
  int _calcSalary = 0;
  int _workDays = 0;
  SalaryEntity? _salaryReceived;
  int workDaysAsMinute = 0;

  int get dayOffs => _dayOffs;
  int get calculatedSalary => _calcSalary;
  int get workDays => _workDays;
  SalaryEntity? get salaryReceived => _salaryReceived;

  _calculateThisMonthSalary() {
    int currentMonthLength = currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay = salaryContract / currentMonthLength;

    // print(countedWorkDays.length);

    int eachDayTimeContractAsMinute = eachDayTimeContract * 60;

    int salaryPerMinute = salaryPerDay ~/ eachDayTimeContractAsMinute;

    // print(salaryPerMinute);

    int workDaysSalary = salaryPerMinute * workDaysAsMinute;

    _calcSalary = workDaysSalary;
  }

  _getWorkDaysWorkTimeAsMinutes() {
    final eachDayAsMinutes = List.generate(listOfCurrentMonthWorkDay.length, (i) {
      //
      DateTime inTime;
      DateTime outTime;
      //
      if (listOfCurrentMonthWorkDay[i].isPublicHoliday) {
        inTime = DateTime(1, 1, 1, 00, 00);
        outTime = DateTime(1, 1, 1, 10, 00);
      } else {
        //
        inTime = DateTime(1, 1, 1, listOfCurrentMonthWorkDay[i].inTime?.hour ?? 0,
            listOfCurrentMonthWorkDay[i].inTime?.minute ?? 0);
        outTime = DateTime(1, 1, 1, listOfCurrentMonthWorkDay[i].outTime?.hour ?? 0,
            listOfCurrentMonthWorkDay[i].outTime?.minute ?? 0);
        //
      }

      return (outTime.difference(inTime).inMinutes);
    });

    workDaysAsMinute =
        eachDayAsMinutes.fold(0, (previousValue, element) => previousValue + element);
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
      _salaryReceived = salaries.firstWhere(
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
