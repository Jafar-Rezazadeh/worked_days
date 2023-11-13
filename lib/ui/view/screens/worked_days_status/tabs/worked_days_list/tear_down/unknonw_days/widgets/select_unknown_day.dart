import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:worked_days/bloc/entities/color_schema.dart';
import 'package:worked_days/ui/extentions/shamsi_formater.dart';

class SelectUnknownDay extends StatelessWidget {
  final List<Jalali> unknownDaysDateTime;
  const SelectUnknownDay({super.key, required this.unknownDaysDateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 100.sp, horizontal: 50.sp),
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: ColorPallet.smoke,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _title(),
          Divider(color: ColorPallet.yaleBlue),
          _listOfUnknownDays(),
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      textDirection: TextDirection.rtl,
      style: TextStyle(
        color: Colors.black,
        fontSize: 10.sp,
      ),
      "یکی از روز های نامشخص رو انتخاب کن و ثبتش کن",
    );
  }

  Widget _listOfUnknownDays() {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        separatorBuilder: (context, index) => SizedBox(height: 10.sp),
        itemCount: unknownDaysDateTime.length,
        itemBuilder: (context, index) {
          return Center(
            child: _item(item: unknownDaysDateTime[index]),
          );
        },
      ),
    );
  }

  Widget _item({required Jalali item}) {
    return GestureDetector(
      onTap: () {
        //Todo: show the add today status and insert it in db and rewrite the controlller for get today status
        print(FormatJalaliTo.dayAndMonth(item.toDateTime()));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorPallet.yaleBlue,
              blurRadius: 5,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50.sp,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorPallet.smoke,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            FormatJalaliTo.dayAndMonth(item.toDateTime()),
            style: const TextStyle(),
          ),
        ),
      ),
    );
  }
}
