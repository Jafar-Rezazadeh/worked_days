import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/widgets/salary_cal_controller.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/bloc/entities/color_schema.dart';

class CalcCurrentMonthSalary extends StatelessWidget {
  final WorkedDaysTabController workedDaysTabController;
  final SalaryCalcController salaryCalcController;
  const CalcCurrentMonthSalary(
      {super.key, required this.workedDaysTabController, required this.salaryCalcController});

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _thisMonthSalary(),
        _workedDaysCount(),
        _dayOff(),
      ],
    );
  }

  Widget _thisMonthSalary() {
    return Row(
      children: [
        Text("حقوق تا امروز: ", style: _titleStyle()),
        Text(
          "${salaryCalcController.calculateThisMonthSalary(null).toString().seRagham()} تومان",
          style: _descriptionStyle(),
        ),
      ],
    );
  }

  Widget _workedDaysCount() {
    return Row(
      children: [
        Text("روز کاری:", style: _titleStyle()),
        Text(
          " ${salaryCalcController.calcCountedWorkDays().length} روز",
          style: _descriptionStyle(
            caution: salaryCalcController.calcCountedWorkDays().isEmpty ? true : false,
          ),
        ),
      ],
    );
  }

  Widget _dayOff() {
    return Row(
      children: [
        Text("روز تعطیل:", style: _titleStyle()),
        Text(
          " ${salaryCalcController.calcDayOffs().length} روز",
          style: _descriptionStyle(
            caution: salaryCalcController.calcDayOffs().isNotEmpty ? true : false,
          ),
        )
      ],
    );
  }

  TextStyle _titleStyle() {
    return TextStyle(
      color: ColorPallet.smoke,
      fontSize: 12.sp,
    );
  }

  TextStyle _descriptionStyle({bool caution = false}) {
    return TextStyle(
      color: caution ? ColorPallet.orange : ColorPallet.green,
      fontSize: 12.sp,
    );
  }
}
