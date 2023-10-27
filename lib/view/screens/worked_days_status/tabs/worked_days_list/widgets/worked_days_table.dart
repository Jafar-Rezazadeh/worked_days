import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/controller/screens/worked_days_status_c/worked_days_list/worked_day_list_tab_controller.dart';
import 'package:worked_days/services/shamsi_formater_service.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/models/color_schema.dart';
import 'package:worked_days/models/worked_day_model.dart';
import 'package:worked_days/view/screens/details_work_day/details_screen.dart';

class WorkedDaysTableWidget extends StatefulWidget {
  final List<WorkDayModel> listOfCurrentWorkedDays;

  const WorkedDaysTableWidget({
    super.key,
    required this.listOfCurrentWorkedDays,
  });

  @override
  State<WorkedDaysTableWidget> createState() => _WorkedDaysTableWidgetState();
}

class _WorkedDaysTableWidgetState extends State<WorkedDaysTableWidget> {
  late WorkedDaysTabController workedDaysTabController = WorkedDaysTabController(context: context);
  late LoadedStableState loadedStableState = workedDaysTabController.loadedStableState;

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
                  widget.listOfCurrentWorkedDays.length,
                  (i) => DataRow(
                    cells: [
                      _title(widget.listOfCurrentWorkedDays[i]),
                      _dateTime(widget.listOfCurrentWorkedDays[i]),
                      _statusAvatar(widget.listOfCurrentWorkedDays[i]),
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
              loadedStableState: loadedStableState,
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
          ShamsiFormatterService.getDayAndMonth(workDayModel.dateTime),
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

  IconData? _getDayAvatarIcon(WorkDayModel workDayModel) {
    if (workDayModel.dayOff) {
      return Icons.close;
    } else {
      return Icons.check;
    }
  }
}
