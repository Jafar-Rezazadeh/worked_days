import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/widgets/salary_cal_controller.dart';
import 'package:worked_days/bloc/models/color_schema.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ShowSavedSalaryCalc extends StatelessWidget {
  final SalaryCalcController salaryCalcController;
  const ShowSavedSalaryCalc({super.key, required this.salaryCalcController});

  //Todo: make a table in db to save salaries

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ifSalaryStored() ? "حقوق پرداخت شده" : "ذخیره حقوق پرداختی",
            style: TextStyle(
              color: ColorPallet.smoke,
              fontSize: 11.sp,
            ),
          ),
          //
          ifSalaryStored()
              ? Text(
                  salaryCalcController.storedSalary?.salaryAmount.toString().seRagham() ?? "",
                  style: TextStyle(
                    color: ColorPallet.smoke,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Container(),

          //
          SizedBox(
            height: 30.sp,
            width: 80.sp,
            child: FilledButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.green),
              ),
              child: Text(
                ifSalaryStored() ? "تغییر" : "ذخیره",
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool ifSalaryStored() {
    return salaryCalcController.storedSalary != null ? true : false;
  }
}
