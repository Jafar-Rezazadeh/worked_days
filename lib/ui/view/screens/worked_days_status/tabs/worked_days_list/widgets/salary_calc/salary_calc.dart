import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/widgets/salary_cal_controller.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/data/entities/color_schema.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/widgets/salary_calc/parts/calc_current_salary.dart';
import 'package:worked_days/ui/view/screens/worked_days_status/tabs/worked_days_list/widgets/salary_calc/parts/show_saved_salary.dart';

class SalaryCalcWidget extends StatelessWidget {
  final WorkedDaysTabController workedDaysTabController;
  const SalaryCalcWidget({
    super.key,
    required this.workedDaysTabController,
  });

  @override
  Widget build(BuildContext context) {
    final SalaryCalcController salaryCalcController = SalaryCalcController(
      workedDaysTabController: workedDaysTabController,
    );

    return Expanded(
      flex: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          height: double.infinity,
          width: double.infinity,
          color: ColorPallet.yaleBlue,
          child: showSideBySide(salaryCalcController),
        ),
      ),
    );
  }

  Widget showSideBySide(SalaryCalcController salaryCalcController) {
    return Row(
      children: [
        CalcCurrentMonthSalary(
          workedDaysTabController: workedDaysTabController,
          salaryCalcController: salaryCalcController,
        ),
        VerticalDivider(
          thickness: 1,
          indent: 0,
          width: 30.sp,
          color: ColorPallet.smoke,
        ),
        ShowSavedSalaryCalc(salaryCalcController: salaryCalcController),
      ],
    );
  }
}
