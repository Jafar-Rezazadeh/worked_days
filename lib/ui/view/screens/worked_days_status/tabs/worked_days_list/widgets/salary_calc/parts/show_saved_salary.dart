import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/widgets/salary_cal_controller.dart';
import 'package:worked_days/bloc/models/color_schema.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ShowSavedSalaryCalc extends StatelessWidget {
  final SalaryCalcController salaryCalcController;
  ShowSavedSalaryCalc({super.key, required this.salaryCalcController});

  final TextEditingController salaryAmountTextFieldController = TextEditingController();

  //Todo: make a table in db to save salaries
  @override
  Widget build(BuildContext context) {
    salaryAmountTextFieldController.text = "${_setSalaryTotextField()} تومان";

    return salaryCalcController.calcCountedWorkDays().isNotEmpty
        ? Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                "روز های کاری این ماه مشخص نیست.",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorPallet.smoke,
                ),
              ),
            ),
          );
  }

  bool ifSalaryStored() {
    return salaryCalcController.storedSalary != null ? true : false;
  }

  Widget _paidSalary() {
    return ifSalaryStored()
        ? Text(
            salaryCalcController.storedSalary?.salaryAmount.toString().seRagham() ?? "",
            style: TextStyle(
              color: ColorPallet.smoke,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        : Container();
  }

  Widget _title() {
    return Text(
      ifSalaryStored() ? "حقوق پرداخت شده" : "ذخیره حقوق پرداختی",
      style: TextStyle(
        color: ColorPallet.smoke,
        fontSize: 11.sp,
      ),
    );
  }

  Widget _updateOrSubmit({required BuildContext context}) {
    return SizedBox(
      height: 30.sp,
      width: 80.sp,
      child: FilledButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _salaryAmountDialog(context: context),
          );
        },
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
    );
  }

  Widget _salaryAmountDialog({required BuildContext context}) {
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
                child: const Text("حقوق ماهیانه از"),
              ),
              //? salary input
              TextField(
                onTap: () => salaryAmountTextFieldController.text = "",
                onTapOutside: (event) {
                  if (salaryAmountTextFieldController.text.isEmpty) {
                    salaryAmountTextFieldController.text = "${_setSalaryTotextField()} تومان";
                  }
                  if (!salaryAmountTextFieldController.text.contains("تومان")) {
                    salaryAmountTextFieldController.text =
                        "${salaryAmountTextFieldController.text} تومان";
                  }
                },
                controller: salaryAmountTextFieldController,
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
                onChanged: (value) =>
                    salaryAmountTextFieldController.text = value.seRagham().toEnglishDigit(),
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
                        //Todo: insert the salary amount to db
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

  String _setSalaryTotextField() {
    if (salaryCalcController.storedSalary != null) {
      return salaryCalcController.storedSalary?.salaryAmount.toString().seRagham() ?? "";
    } else {
      return salaryCalcController
          .workedDaysTabController.loadedStableState.settingsModel.salaryDefaultAmount
          .toString()
          .seRagham();
    }
  }
}
