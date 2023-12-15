import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../core/theme/color_schema.dart';
import '../../../work_days/domain/entities/work_days.dart';
import '../../domain/entities/salary.dart';
import '../bloc/cubit/salary_cubit.dart';
import 'calc_current_month_salary.dart';
import 'show_saved_salary.dart';

class SalaryMainWidget extends StatefulWidget {
  final Jalali currentMonth;
  final List<WorkDay> listOfCurrentMonthWorkDay;
  const SalaryMainWidget(
      {super.key, required this.currentMonth, required this.listOfCurrentMonthWorkDay});

  @override
  State<SalaryMainWidget> createState() => _SalaryMainWidgetState();
}

class _SalaryMainWidgetState extends State<SalaryMainWidget> {
  @override
  void initState() {
    BlocProvider.of<SalaryCubit>(context).getSalaries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalaryCubit, SalaryState>(
      builder: (context, state) {
        return Expanded(
          flex: 2,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              height: double.infinity,
              width: double.infinity,
              color: ColorPallet.yaleBlue,
              child: _stateDecider(state),
            ),
          ),
        );
      },
    );
  }

  Widget _stateDecider(SalaryState state) {
    if (state is SalaryEmptyState) {
      return const Center(
        child: Text("salary empty state"),
      );
    }
    if (state is SalaryLoadingState) {
      return Center(
          child: CircularProgressIndicator(
        color: ColorPallet.smoke,
      ));
    }
    if (state is SalaryLoadedState) {
      return _showPaidSalaryAndCalcSalary(state.listOfSalaries);
    }
    if (state is SalaryErrorState) {
      return Center(
        child: Text(
          state.errorMessage,
          style: TextStyle(color: ColorPallet.orange),
        ),
      );
    } else {
      return const Center(child: Text("unknown error"));
    }
  }

  Widget _showPaidSalaryAndCalcSalary(List<Salary> salaries) {
    SalaryCalculation salaryCalculation = SalaryCalculation(
      salaries: salaries,
      currentMonth: widget.currentMonth,
      listOfCurrentMonthWorkDay: widget.listOfCurrentMonthWorkDay,
    );
    return Row(
      children: [
        CalcCurrentMonthSalary(
          salaryCalculation: salaryCalculation,
        ),
        VerticalDivider(
          thickness: 1,
          indent: 0,
          width: 30.sp,
          color: ColorPallet.smoke,
        ),
        ShowSavedSalaryCalc(salaryCalculation: salaryCalculation),
      ],
    );
  }
}

class SalaryCalculation {
  final Jalali currentMonth;
  final List<WorkDay> listOfCurrentMonthWorkDay;
  final List<Salary> salaries;

  SalaryCalculation({
    required this.salaries,
    required this.currentMonth,
    required this.listOfCurrentMonthWorkDay,
  });

  int calculateThisMonthSalary(int? salary) {
    salary ??= 8000000;

    int currentMonthLength = currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay = salary / currentMonthLength;

    List<WorkDay> countedWorkDays = calcCountedWorkDays();
    // print(countedWorkDays.length);

    int countedWorkDaysSum = (salaryPerDay * countedWorkDays.length).toInt();

    return countedWorkDaysSum;
  }

  List<WorkDay> calcCountedWorkDays() {
    return listOfCurrentMonthWorkDay
        .where(
          (element) => element.isWorkDay == true || element.isPublicHoliday == true,
        )
        .toList();
  }

  List<WorkDay> calcDayOffs() {
    return listOfCurrentMonthWorkDay.where((element) => element.isDayOff == true).toList();
  }

  Salary? getCurrentSelectedSalary() {
    try {
      return salaries.firstWhere(
        (element) =>
            element.dateTime.toJalali().month == currentMonth.month &&
            element.dateTime.toJalali().year == currentMonth.year,
      );
    } catch (e) {
      return null;
    }
  }
}
