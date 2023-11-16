import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/controller/screens/worked_days_status_screen/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/ui/extentions/shamsi_formater.dart';
import 'package:worked_days/bloc/entities/color_schema.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:worked_days/ui/view/screens/details_work_day/details_screen.dart';

class WorkedDaysTableWidget extends StatelessWidget {
  final WorkedDaysTabController workedDaysTabController;
  final BuildContext context;

  const WorkedDaysTableWidget({
    super.key,
    required this.context,
    required this.workedDaysTabController,
  });

  @override
  Widget build(BuildContext context) {
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
                  workedDaysTabController.listOfCurrentMonthWorkedDays.length,
                  (i) => DataRow(
                    cells: [
                      _title(workedDaysTabController.listOfCurrentMonthWorkedDays[i]),
                      _dateTime(workedDaysTabController.listOfCurrentMonthWorkedDays[i]),
                      _statusAvatar(workedDaysTabController.listOfCurrentMonthWorkedDays[i]),
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

  _title(WorkDayModel workDayModel) {
    return DataCell(
      Center(child: Text(workDayModel.title)),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsWorkDay(
              loadedStableState: workedDaysTabController.loadedStableState,
              workDayModel: workDayModel,
            ),
          ),
        );
      },
    );
  }

  _dateTime(WorkDayModel workDayModel) {
    return DataCell(
      Center(
        child: Text(
          FormatJalaliTo.dayAndMonth(workDayModel.dateTime),
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailsWorkDay(
              loadedStableState: workedDaysTabController.loadedStableState,
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
              loadedStableState: workedDaysTabController.loadedStableState,
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

  IconData? _getDayAvatarIcon(WorkDayModel workDayModel) {
    if (workDayModel.dayOff) {
      return Icons.close;
    } else {
      return Icons.check;
    }
  }
}
