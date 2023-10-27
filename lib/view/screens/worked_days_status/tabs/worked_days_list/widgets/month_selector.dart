import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/models/color_schema.dart';
import 'package:worked_days/services/shamsi_formater_service.dart';

class MonthSelectorWidget extends StatefulWidget {
  final Function(Jalali value) onCurrentMonthChanged;
  final Jalali currentMonth;
  const MonthSelectorWidget({
    super.key,
    required this.onCurrentMonthChanged,
    required this.currentMonth,
  });

  @override
  State<MonthSelectorWidget> createState() => _MonthSelectorWidgetState();
}

class _MonthSelectorWidgetState extends State<MonthSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                widget.onCurrentMonthChanged(widget.currentMonth.addMonths(-1));
              },
              style: backAndForwardButtonStyle(),
              child: const Icon(Icons.keyboard_arrow_left),
            ),
            GestureDetector(
              onTap: () async {},
              child: Text(ShamsiFormatterService.getYearAndMonth(widget.currentMonth)),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onCurrentMonthChanged(widget.currentMonth.addMonths(1));
              },
              style: backAndForwardButtonStyle(),
              child: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }

  ButtonStyle backAndForwardButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          side: BorderSide(color: ColorPallet.orange, width: 2),
        ),
      ),
    );
  }
}
