import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/widgets/salary_cal_controller.dart';
import 'package:worked_days/bloc/models/color_schema.dart';

class ShowSavedSalaryCalc extends StatelessWidget {
  final SalaryCalcController salaryCalcController;
  const ShowSavedSalaryCalc({super.key, required this.salaryCalcController});

  //Todo: make the logical code for saving the paid salary (make a table in db and save it there)

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ذخیره حقوق پرداختی",
            style: TextStyle(
              color: ColorPallet.smoke,
              fontSize: 12.sp,
            ),
          ),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.green),
            ),
            child: Text(
              "ذخیره",
              style: TextStyle(
                fontSize: 12.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
