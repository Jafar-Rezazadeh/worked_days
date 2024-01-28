import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../core/theme/color_schema.dart';
import '../../domain/entities/salary.dart';
import '../../domain/entities/salary_calc.dart';
import '../bloc/cubit/salary_cubit.dart';

Widget salaryAmountDialog({
  required BuildContext context,
  required TextEditingController textEditingController,
  required SalaryCalculationEntity salaryCalculation,
}) {
  return Dialog(
    child: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Container(
        decoration: BoxDecoration(
          color: ColorPallet.smoke,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(10),
        width: 50.sp,
        height: 150.sp,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //? title
            Title(
              color: Colors.black,
              child: const Text("حقوق پرداخت شده رو به تومان وارد کنید"),
            ),
            //? salary input
            TextField(
              onTap: () => textEditingController.text = "",
              onTapOutside: (event) {
                textEditingController.text = _addDefaulValueToTextField(textEditingController.text);

                textEditingController.text = _addSuffixToPaidSalary(textEditingController.text);
              },
              controller: textEditingController,
              cursorColor: ColorPallet.yaleBlue,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorPallet.yaleBlue),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorPallet.yaleBlue),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]'))],
              onChanged: (value) => textEditingController.text = value.seRagham().toEnglishDigit(),
            ),

            //?submit/cancell
            SizedBox(
              height: 30,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {
                      _submit(
                        textEditingController,
                        salaryCalculation.currentMonth,
                        context,
                        salaryCalculation,
                      );
                      //
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue),
                    ),
                    child: const Text("ذخیره"),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue),
                    ),
                    child: const Text("لغو"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

void _submit(TextEditingController textEditingController, Jalali currentMonth, BuildContext context,
    SalaryCalculationEntity salaryCalculation) {
  int salaryAmont =
      int.parse(textEditingController.text.extractNumber(toDigit: NumStrLanguage.English));

  SalaryEntity salary = SalaryEntity(
    id: salaryCalculation.currentSalary?.id ?? 0,
    dateTime: currentMonth.toDateTime(),
    salaryAmount: salaryAmont,
  );

  BlocProvider.of<SalaryCubit>(context).deleteSalary(salary.id);

  BlocProvider.of<SalaryCubit>(context).insertSalary(salary);
}

String _addSuffixToPaidSalary(String text) {
  if (!text.contains("تومان")) {
    return text = "$text تومان";
  } else {
    return text;
  }
}

String _addDefaulValueToTextField(String text) {
  if (text.isEmpty) {
    return text = "0 تومان";
  } else {
    return text;
  }
}
