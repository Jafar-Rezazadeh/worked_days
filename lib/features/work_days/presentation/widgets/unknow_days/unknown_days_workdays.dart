import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../../core/theme/color_schema.dart';
import '../../../domain/entities/work_days.dart';
import '../../bloc/cubit/workdays_cubit.dart';
import 'tear_down/select_unknowday.dart';

class UnknownDaysWorkDays extends StatelessWidget {
  final Jalali currentDate;
  final List<WorkDay> listOfWorkDays;

  const UnknownDaysWorkDays({super.key, required this.currentDate, required this.listOfWorkDays});

  @override
  Widget build(BuildContext context) {
    final List<Jalali> unknownDays = extractUnknownDaysOfCurrentMonth();
    return unknownDays.isNotEmpty
        ? Expanded(
            flex: 1,
            child: Container(
              color: ColorPallet.orange,
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: ColorPallet.yaleBlue),
                    "روزهای نامشخص ${unknownDays.length} روز",
                  ),
                  SizedBox(
                    height: 30.sp,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: BlocProvider.of<WorkdaysCubit>(context),
                            child: SelectUnknownDay(unknownDaysDate: unknownDays),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return ColorPallet.yaleBlue.withOpacity(0.5);
                          } else {
                            return ColorPallet.yaleBlue;
                          }
                        }),
                        foregroundColor: MaterialStatePropertyAll<Color>(ColorPallet.smoke),
                      ),
                      child: const Text("تأیین وضعیت"),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  List<Jalali> extractUnknownDaysOfCurrentMonth() {
    Jalali localCurrentDate = currentDate;

    localCurrentDate = localCurrentDate.addDays(-currentDate.day);

    List<Jalali> unknownDaysJalaliDateList = [];

    for (int i = 1; i <= currentDate.monthLength; i++) {
      localCurrentDate = localCurrentDate.addDays(1);

      if (listOfWorkDays.any(
        (element) =>
            element.date.toJalali().month == localCurrentDate.month &&
            element.date.toJalali().day == localCurrentDate.day,
      )) {
      } else {
        unknownDaysJalaliDateList.add(localCurrentDate);
      }
    }

    //print("unknown days ${unknownDaysJalaliDateList.length}");
    // print("list of unknown days Date: $unknownDaysJalaliDateList");

    if (currentDate.year == Jalali.now().year && currentDate.month == Jalali.now().month) {
      unknownDaysJalaliDateList =
          unknownDaysJalaliDateList.where((element) => element.day < Jalali.now().day).toList();
    }

    return unknownDaysJalaliDateList;
  }
}
