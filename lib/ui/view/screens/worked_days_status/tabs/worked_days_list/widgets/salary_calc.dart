import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/widgets/salary_cal_controller.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/bloc/models/color_schema.dart';

class SalaryCalcWidget extends StatelessWidget {
  final WorkedDaysTabController workedDaysTabController;
  const SalaryCalcWidget({
    super.key,
    required this.workedDaysTabController,
  });

  @override
  Widget build(BuildContext context) {
    if (workedDaysTabController.loadedStableState.settingsModel.salaryModel.salaryAmount != null) {
      final SalaryCalcController salaryCalcController = SalaryCalcController(
        currentMonth: workedDaysTabController.currentMonth,
        listOfCurrentWorkedDays: workedDaysTabController.listOfCurrentMonthWorkedDays,
        loadedStableState: workedDaysTabController.loadedStableState,
      );
      return Expanded(
        flex: 2,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            alignment: Alignment.centerRight,
            height: double.infinity,
            width: double.infinity,
            color: ColorPallet.yaleBlue,
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  style: TextStyle(
                    color: ColorPallet.smoke,
                    fontSize: 15.sp,
                  ),
                  TextSpan(
                    text: "حقوق این ماه: ",
                    children: [
                      //? this month salary
                      TextSpan(
                        text: salaryCalcController.calculateThisMonthSalary(),
                        style: TextStyle(color: ColorPallet.green),
                      ),
                      //? worked Days count
                      TextSpan(
                        text: "\nروز کاری:",
                        children: [
                          TextSpan(
                            text:
                                " ${salaryCalcController.calcCountedWorkDays().length.toString()} روز",
                            style: TextStyle(color: ColorPallet.green),
                          ),
                        ],
                      ),
                      //? dayOff count
                      TextSpan(
                        text: "\nروز تعطیل:",
                        children: [
                          TextSpan(
                            text: " ${salaryCalcController.calcDayOffs().length.toString()} روز",
                            style: TextStyle(
                              color: salaryCalcController.calcDayOffs().isEmpty
                                  ? ColorPallet.green
                                  : ColorPallet.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 2,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            color: ColorPallet.yaleBlue,
            child: Column(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "لطفا از بخش تنظیمات حقوق را وارد کنید",
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: ColorPallet.smoke,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
