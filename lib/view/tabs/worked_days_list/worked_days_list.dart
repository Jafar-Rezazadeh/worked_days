import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/controller/shamsi_formater.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/view/screens/details_screen.dart';

class WorkedDaysListPage extends StatelessWidget {
  final ValueChanged<Jalali> onCureentMonthChanged;
  final List<WorkDayModel> listOfCurrentWorkedDays;
  final BuildContext context;
  final Jalali currentMonth;
  final LoadedStableState loadedStableState;
  const WorkedDaysListPage({
    super.key,
    required this.onCureentMonthChanged,
    required this.listOfCurrentWorkedDays,
    required this.currentMonth,
    required this.context,
    required this.loadedStableState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _monthSelector(),
        _workedDaysTable(),
        _salaryCalculation(),
      ],
    );
  }

  _monthSelector() {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              splashRadius: 30,
              onPressed: () {
                onCureentMonthChanged(currentMonth.addMonths(-1));
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            GestureDetector(
              onTap: () async {},
              child: Text(ShamsiFormatter.getYearAndMonth(currentMonth)),
            ),
            IconButton(
              splashRadius: 30,
              onPressed: () {
                onCureentMonthChanged(currentMonth.addMonths(1));
              },
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }

  _workedDaysTable() {
    return Expanded(
      flex: 6,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: DataTable(
                showBottomBorder: true,
                border: TableBorder(
                  horizontalInside:
                      BorderSide(width: 1, color: ColorPallet.yaleBlue.withOpacity(0.2)),
                ),
                headingTextStyle: TextStyle(
                  fontSize: 15.sp,
                  color: ColorPallet.yaleBlue,
                  fontFamily: "Vazir",
                ),
                dataTextStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontFamily: "Vazir",
                ),
                columns: [
                  const DataColumn(label: Expanded(child: Center(child: Text("وضعیت")))),
                  const DataColumn(label: Expanded(child: Center(child: Text("تاریخ")))),
                  DataColumn(label: Container()),
                ],
                rows: List<DataRow>.generate(
                  listOfCurrentWorkedDays.length,
                  (i) => DataRow(
                    cells: [
                      _title(listOfCurrentWorkedDays[i]),
                      _dateTime(listOfCurrentWorkedDays[i]),
                      _statusAvatar(listOfCurrentWorkedDays[i]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _dateTime(WorkDayModel workDayModel) {
    return DataCell(
      Center(
        child: Text(
          ShamsiFormatter.getDayAndMonth(workDayModel.dateTime),
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsWorkDay(
              loadedStableState: loadedStableState,
              workDayModel: workDayModel,
            ),
          ),
        );
      },
    );
  }

  _statusAvatar(WorkDayModel workDayModel) {
    return DataCell(
      Center(
        child: CircleAvatar(
          backgroundColor: _getDayAvatarColor(workDayModel),
          child: workDayModel.publicHoliday == false
              ? Icon(
                  _getDayAvatarIcon(workDayModel),
                  color: ColorPallet.smoke,
                )
              : Image.asset(
                  'assets/icons/horizontalline.png',
                  height: 20.sp,
                  width: 20.sp,
                ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsWorkDay(
              loadedStableState: loadedStableState,
              workDayModel: workDayModel,
            ),
          ),
        );
      },
    );
  }

  _getDayAvatarColor(WorkDayModel workDayModel) {
    if (workDayModel.dayOff) {
      return Colors.red;
    }
    if (workDayModel.publicHoliday) {
      return ColorPallet.green;
    }
    if (workDayModel.workDay) {
      return ColorPallet.green.withGreen(220);
    }
  }

  _title(WorkDayModel workDayModel) {
    return DataCell(
      Center(child: Text(workDayModel.title)),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsWorkDay(
              loadedStableState: loadedStableState,
              workDayModel: workDayModel,
            ),
          ),
        );
      },
    );
  }

  IconData? _getDayAvatarIcon(WorkDayModel workDayModel) {
    if (workDayModel.dayOff) {
      return Icons.close;
    } else {
      return Icons.check;
    }
  }

  Widget _salaryCalculation() {
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
