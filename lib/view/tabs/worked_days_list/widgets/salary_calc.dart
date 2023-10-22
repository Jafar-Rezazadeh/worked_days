import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/color_schema.dart';
import 'package:worked_days/models/worked_day_model.dart';

class SalaryCalcWidget extends StatelessWidget {
  final LoadedStableState loadedStableState;
  final Jalali currentMonth;
  final List<WorkDayModel> listOfCurrentWorkedDays;
  const SalaryCalcWidget({
    super.key,
    required this.loadedStableState,
    required this.currentMonth,
    required this.listOfCurrentWorkedDays,
  });

  @override
  Widget build(BuildContext context) {
    if (loadedStableState.settingsModel.salaryModel.salaryAmount != null) {
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
                        text: _calculateThisMonthSalary(),
                        style: TextStyle(color: ColorPallet.green),
                      ),
                      //? worked Days count
                      TextSpan(
                        text: "\nروز کاری:",
                        children: [
                          TextSpan(
                            text: " ${_calcCountedWorkDays().length.toString()} روز",
                            style: TextStyle(color: ColorPallet.green),
                          ),
                        ],
                      ),
                      //? dayOff count
                      TextSpan(
                        text: "\nروز تعطیل:",
                        children: [
                          TextSpan(
                            text: " ${_calcDayOffs().length.toString()} روز",
                            style: TextStyle(
                              color:
                                  _calcDayOffs().isEmpty ? ColorPallet.green : ColorPallet.orange,
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

  String _calculateThisMonthSalary() {
    int currentMonthLength = currentMonth.monthLength;
    // print(currentMonthLength);

    double salaryPerDay =
        loadedStableState.settingsModel.salaryModel.salaryAmount! / currentMonthLength;

    List<WorkDayModel> countedWorkDays = _calcCountedWorkDays();
    // print(countedWorkDays.length);

    int countedWorkDaysSum = (salaryPerDay * countedWorkDays.length).toInt();

    return "${countedWorkDaysSum.toString().seRagham()} تومان";
  }

  List<WorkDayModel> _calcCountedWorkDays() {
    return listOfCurrentWorkedDays
        .where(
          (element) => element.workDay == true || element.publicHoliday == true,
        )
        .toList();
  }

  List<WorkDayModel> _calcDayOffs() {
    return listOfCurrentWorkedDays.where((element) => element.dayOff == true).toList();
  }
}
