import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../core/theme/color_schema.dart';
import '../../../../core/utils/shamsi_formater.dart';
import '../../domain/entities/work_days.dart';
import '../../../../core/utils/extentions.dart';

class ListWorkDays extends StatelessWidget {
  final List<WorkDay> listOfWorkDays;
  final Jalali currentDate;

  ListWorkDays({super.key, required this.listOfWorkDays, required this.currentDate});

  final ScrollController horizontalScrollCont = ScrollController();
  final ScrollController verticalScrollCont = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.left,
          controller: verticalScrollCont,
          child: SingleChildScrollView(
            controller: verticalScrollCont,
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Scrollbar(
                controller: horizontalScrollCont,
                trackVisibility: true,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: horizontalScrollCont,
                  scrollDirection: Axis.horizontal,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: _currentMonthWorkDays().isEmpty ? _noData() : _dataTable(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  DataTable _dataTable() {
    return DataTable(
      border: TableBorder(
        horizontalInside: BorderSide(width: 1, color: ColorPallet.yaleBlue.withOpacity(0.2)),
        verticalInside: BorderSide(width: 1, color: ColorPallet.yaleBlue.withOpacity(0.2)),
      ),
      headingTextStyle: TextStyle(
        fontSize: 13.sp,
        color: ColorPallet.yaleBlue,
        fontFamily: "Vazir",
      ),
      dataTextStyle: TextStyle(
        fontSize: 12.sp,
        color: Colors.black,
        fontFamily: "Vazir",
      ),
      columnSpacing: 1.sw / 12,
      headingRowColor: MaterialStatePropertyAll<Color>(
        ColorPallet.yaleBlue.withOpacity(0.2),
      ),
      columns: [
        const DataColumn(label: Expanded(child: Center(child: Text("ورود و خروج")))),
        const DataColumn(label: Expanded(child: Center(child: Text("تاریخ")))),
        const DataColumn(label: Expanded(child: Center(child: Text("وضعیت")))),
        DataColumn(label: Container()),
      ],
      rows: List<DataRow>.generate(
        _currentMonthWorkDays().length,
        (i) => DataRow(
          //Todo: make the list selectable()
          cells: [
            _inOutTime(_currentMonthWorkDays()[i]),
            _dateTime(_currentMonthWorkDays()[i]),
            _title(_currentMonthWorkDays()[i]),
            _statusAvatar(_currentMonthWorkDays()[i]),
          ],
        ),
      ),
    );
  }

  List<WorkDay> _currentMonthWorkDays() {
    try {
      List<WorkDay> result = listOfWorkDays
          .where(
            (element) =>
                element.date.toJalali().month == currentDate.month &&
                element.date.toJalali().year == currentDate.year,
          )
          .toList();

      result.sort((a, b) => a.date.compareTo(b.date));
      return result;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  DataCell _title(WorkDay workDay) {
    return DataCell(
      Center(child: Text(workDay.title)),
    );
  }

  DataCell _dateTime(WorkDay workDay) {
    return DataCell(
      Center(
        child: Text(
          FormatJalaliTo.dayAndMonth(workDay.date),
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  DataCell _statusAvatar(WorkDay workDay) {
    return DataCell(
      Center(
        child: CircleAvatar(
          radius: 15.sp,
          backgroundColor: _getDayAvatarColor(workDay),
          child: !workDay.isPublicHoliday
              ? Icon(
                  _getDayAvatarIcon(workDay),
                  color: ColorPallet.smoke,
                )
              : Image.asset(
                  'assets/icons/horizontalline.png',
                  height: 20.sp,
                  width: 20.sp,
                ),
        ),
      ),
    );
  }

  DataCell _inOutTime(WorkDay currentMonthWorkDay) {
    return DataCell(
      Center(
        child: Text(currentMonthWorkDay.inTime?.toStringFormat ?? "-"),
      ),
    );
  }

  _getDayAvatarColor(WorkDay workDay) {
    if (workDay.isDayOff) {
      return Colors.red;
    }
    if (workDay.isPublicHoliday) {
      return ColorPallet.green;
    }
    if (workDay.isWorkDay) {
      return ColorPallet.green.withGreen(220);
    }
  }

  IconData? _getDayAvatarIcon(WorkDay workDay) {
    if (workDay.isDayOff) {
      return Icons.close;
    } else {
      return Icons.check;
    }
  }

  Widget _noData() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.sp),
      child: const Center(
        child: Text("داده ای ثپت نشده لطفا وضعیت روز ها را مشخص کنید."),
      ),
    );
  }
}
