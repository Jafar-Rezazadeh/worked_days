import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/features/settings/presentation/cubit/cubit/settings_cubit.dart';

import '../../../core/theme/color_schema.dart';
import '../../work_days/domain/entities/work_days.dart';
import '../domain/entities/salary.dart';
import '../domain/entities/salary_calc.dart';
import 'bloc/cubit/salary_cubit.dart';
import 'widgets/calc_current_month_salary.dart';
import 'widgets/show_saved_salary.dart';

class SalaryMainWidget extends StatefulWidget {
  final Jalali currentMonth;
  final List<WorkDay> listOfCurrentMonthWorkDay;
  const SalaryMainWidget(
      {super.key, required this.currentMonth, required this.listOfCurrentMonthWorkDay});

  @override
  State<SalaryMainWidget> createState() => _SalaryMainWidgetState();
}

class _SalaryMainWidgetState extends State<SalaryMainWidget> {
  late int salaryContract;
  late int workDayTimeContract;
  @override
  void initState() {
    BlocProvider.of<SalaryCubit>(context).getSalaries();
    // _getSalaryContract();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getSalaryContract();
  }

  _getSalaryContract() async {
    final settings = await BlocProvider.of<SettingsCubit>(context, listen: true).getSettings();
    if (mounted) {
      salaryContract = settings.salaryAmountContract;
      workDayTimeContract = settings.workDayTimeContractAsHours;
    }
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

  Widget _showPaidSalaryAndCalcSalary(List<SalaryEntity> salaries) {
    //
    SalaryCalculationEntity salaryCalculation = SalaryCalculationEntity(
      eachDayTimeContract: workDayTimeContract,
      salaryContract: salaryContract,
      salaries: salaries,
      currentMonth: widget.currentMonth,
      listOfCurrentMonthWorkDay: widget.listOfCurrentMonthWorkDay,
    );
    //
    return Row(
      children: [
        salaryContract == 0
            ? noSalaryContractSet()
            : CalcCurrentMonthSalary(
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

Widget noSalaryContractSet() {
  return Expanded(
    child: Text(
      "لطفا از بخش تنظیمات حقوق قراردادی را مشخص کنید.",
      style: TextStyle(
        fontSize: 13.sp,
        color: ColorPallet.smoke,
      ),
    ),
  );
}
