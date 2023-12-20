import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../core/theme/color_schema.dart';
import '../bloc/cubit/salary_cubit.dart';
import 'salary_amount_dialog.dart';
import 'salary_main_widget.dart';

class ShowSavedSalaryCalc extends StatelessWidget {
  final SalaryCalculation salaryCalculation;

  ShowSavedSalaryCalc({super.key, required this.salaryCalculation});

  final TextEditingController salaryAmountTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    salaryAmountTextFieldController.text = "0 تومان";
    return salaryCalculation.calcCountedWorkDays().isNotEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _title(),
                _paidSalary(),
                _updateOrSubmit(context: context),
              ],
            ),
          )
        : Expanded(
            child: Center(
              child: Text(
                "روز های کاری در این ماه نیست.",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorPallet.smoke,
                ),
              ),
            ),
          );
  }

  Widget _title() {
    return Text(
      "حقوق پرداخت شده",
      style: TextStyle(
        color: ColorPallet.smoke,
        fontSize: 11.sp,
      ),
    );
  }

  Widget _paidSalary() {
    return Text(
      "${salaryCalculation.getCurrentSelectedSalary()?.salaryAmount.toString().seRagham() ?? 0} تومان",
      style: TextStyle(
        color: ColorPallet.green,
        fontSize: 11.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _updateOrSubmit({required BuildContext context}) {
    return SizedBox(
      height: 25.sp,
      width: 80.sp,
      child: FilledButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider.value(
              value: BlocProvider.of<SalaryCubit>(context),
              child: salaryAmountDialog(
                context: context,
                salaryCalculation: salaryCalculation,
                textEditingController: salaryAmountTextFieldController,
              ),
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.deepYellow),
          shadowColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue.withBlue(0)),
          elevation: const MaterialStatePropertyAll<double>(5),
          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(5)),
        ),
        child: Text(
          salaryCalculation.getCurrentSelectedSalary() != null ? "بروز رسانی" : "ذخیره",
          style: TextStyle(
            fontSize: 10.sp,
            color: ColorPallet.yaleBlue,
          ),
        ),
      ),
    );
  }
}
