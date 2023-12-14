import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../../../core/theme/color_schema.dart';
import '../../../../../../core/utils/shamsi_formater.dart';
import '../../../bloc/cubit/workdays_cubit.dart';
import '../../../pages/get_today_status.dart';

class SelectUnknownDay extends StatelessWidget {
  final List<Jalali> unknownDaysDate;

  const SelectUnknownDay({super.key, required this.unknownDaysDate});

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
        itemCount: unknownDaysDate.length,
        itemBuilder: (context, index) {
          return Center(
            child: _item(item: unknownDaysDate[index], context: context),
          );
        },
      ),
    );
  }

  Widget _item({required Jalali item, required BuildContext context}) {
    return GestureDetector(
      onTap: () => _getUnkownDayStatusAndSaveIt(context, item),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: ColorPallet.yaleBlue, blurRadius: 5, spreadRadius: 1)],
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
          child: Text(FormatJalaliTo.dayAndMonth(item.toDateTime()), style: const TextStyle()),
        ),
      ),
    );
  }

  void _getUnkownDayStatusAndSaveIt(BuildContext context, Jalali item) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<WorkdaysCubit>(context),
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: GetTodayStatus(
            currentDate: item.toDateTime(),
            onSubmit: () {
              Navigator.of(context)
                ..pop()
                ..pop();
            },
          ),
        ),
      ),
    );
  }
}
