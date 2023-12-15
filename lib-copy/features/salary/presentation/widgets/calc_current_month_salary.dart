import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../core/theme/color_schema.dart';
import 'salary_main_widget.dart';

class CalcCurrentMonthSalary extends StatelessWidget {
  final SalaryCalculation salaryCalculation;
  const CalcCurrentMonthSalary({
    required this.salaryCalculation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        Text("حقوق محاسبه شده: ", style: _titleStyle()),
        Text(
          "${salaryCalculation.calculateThisMonthSalary(null).toString().seRagham()} تومان",
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
          " ${salaryCalculation.calcCountedWorkDays().length} روز",
          style: _descriptionStyle(
            caution: salaryCalculation.calcCountedWorkDays().isEmpty ? true : false,
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
          " ${salaryCalculation.calcDayOffs().length} روز",
          style: _descriptionStyle(
            caution: salaryCalculation.calcDayOffs().isNotEmpty ? true : false,
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
