import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/controller/shamsi_formater.dart';
import 'package:worked_days/cubit/main_cubit_state.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/worked_day_model.dart';
import 'package:worked_days/view/screens/details_screen.dart';

class WorkedDaysListPage extends StatelessWidget {
  final ValueChanged<Jalali> onCureentDateTimeChanged;
  final List<WorkDayModel> listOfCurrentWorkedDays;
  final BuildContext context;
  final Jalali currentDateTime;
  final LoadedStableState loadedStableState;
  const WorkedDaysListPage({
    super.key,
    required this.onCureentDateTimeChanged,
    required this.listOfCurrentWorkedDays,
    required this.currentDateTime,
    required this.context,
    required this.loadedStableState,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _monthSelector(),
        _workedDaysTable(),
      ],
    );
  }

  _monthSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashRadius: 30,
            onPressed: () {
              onCureentDateTimeChanged(currentDateTime.addMonths(-1));
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          GestureDetector(
            onTap: () async {},
            child: Text(ShamsiFormatter.getYearAndMonth(currentDateTime)),
          ),
          IconButton(
            splashRadius: 30,
            onPressed: () {
              onCureentDateTimeChanged(currentDateTime.addMonths(1));
            },
            icon: const Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }

  _workedDaysTable() {
    return SizedBox(
      width: double.infinity,
      height: loadedStableState.screenSize.height / 1.5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: DataTable(
              showBottomBorder: true,
              border: TableBorder(
                horizontalInside:
                    BorderSide(width: 1, color: ColorPallet.yaleBlue.withOpacity(0.2)),
              ),
              headingTextStyle: TextStyle(
                fontSize: loadedStableState.screenSize.width / 30,
                color: ColorPallet.yaleBlue,
                fontFamily: "Vazir",
              ),
              dataTextStyle: TextStyle(
                fontSize: loadedStableState.screenSize.width / 35,
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
                  height: loadedStableState.screenSize.width / 15,
                  width: loadedStableState.screenSize.width / 15,
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
}
