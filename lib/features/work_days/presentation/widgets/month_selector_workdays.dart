import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../core/theme/color_schema.dart';
import '../../../../core/utils/shamsi_formater.dart';

class MonthSelectorWorkDays extends StatelessWidget {
  final Function(Jalali value) onCurrentDateChanged;
  final Jalali currentDate;

  const MonthSelectorWorkDays({
    super.key,
    required this.onCurrentDateChanged,
    required this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _backWard(),
            GestureDetector(
              onTap: () async {},
              child: Text(FormatJalaliTo.yearAndMonth(currentDate)),
            ),
            _forWard(),
          ],
        ),
      ),
    );
  }

  ElevatedButton _forWard() {
    return ElevatedButton(
      onPressed: () {
        if (_selectedDateNotBiggerThanNow()) {
          onCurrentDateChanged(currentDate.addMonths(1));
        }
      },
      style:
          _selectedDateNotBiggerThanNow() ? _backAndForwardButtonStyle() : _disabledButtonStyle(),
      child: const Icon(Icons.keyboard_arrow_right),
    );
  }

  ElevatedButton _backWard() {
    return ElevatedButton(
      onPressed: () {
        onCurrentDateChanged(currentDate.addMonths(-1));
      },
      style: _backAndForwardButtonStyle(),
      child: const Icon(Icons.keyboard_arrow_left),
    );
  }

  ButtonStyle _backAndForwardButtonStyle() {
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

  ButtonStyle _disabledButtonStyle() {
    return ButtonStyle(
      enableFeedback: false,
      splashFactory: NoSplash.splashFactory,
      backgroundColor: MaterialStatePropertyAll<Color>(ColorPallet.yaleBlue.withOpacity(0.5)),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.sp)),
          side: BorderSide(color: ColorPallet.yaleBlue.withOpacity(0.3), width: 2),
        ),
      ),
    );
  }

  bool _selectedDateNotBiggerThanNow() {
    return currentDate.month == Jalali.now().month && currentDate.year == Jalali.now().year ||
            !currentDate.compareTo(Jalali.now()).isNegative
        ? false
        : true;
  }
}
