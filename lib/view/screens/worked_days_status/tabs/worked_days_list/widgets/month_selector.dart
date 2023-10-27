import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/services/shamsi_formater_service.dart';

class MonthSelectorWidget extends StatelessWidget {
  final Function(Jalali value) onCurrentMonthChanged;
  final Jalali currentMonth;
  const MonthSelectorWidget({
    super.key,
    required this.onCurrentMonthChanged,
    required this.currentMonth,
  });

  @override
  Widget build(BuildContext context) {
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
                onCurrentMonthChanged(currentMonth.addMonths(-1));
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            GestureDetector(
              onTap: () async {},
              child: Text(ShamsiFormatterService.getYearAndMonth(currentMonth)),
            ),
            IconButton(
              splashRadius: 30,
              onPressed: () {
                onCurrentMonthChanged(currentMonth.addMonths(1));
              },
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
