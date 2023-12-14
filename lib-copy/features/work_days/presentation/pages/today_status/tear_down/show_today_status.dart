import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/ui/extentions/shamsi_formater.dart';
import 'package:worked_days/ui/theme/color_schema.dart';

import '../../../../../../core/utils/extentions.dart';
import '../../../../domain/entities/work_days.dart';
import '../../../bloc/cubit/workdays_cubit.dart';

class ShowTodayStatus extends StatelessWidget {
  final BuildContext context;
  final WorkDay todayStatus;

  const ShowTodayStatus({
    super.key,
    required this.todayStatus,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        height: 0.75.sh,
        width: 1.sw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _titleAndTodayDate(),
            _todayStatusTitle(),
            _inOutTime(),
            _shortDescription(),
            _updateButton(),
          ],
        ),
      ),
    );
  }

  Widget _titleAndTodayDate() {
    return Column(
      children: [
        _customizedText("وضعیت امروز ", color: ColorPallet.yaleBlue, sizeMultiplier: 1.8),
        SizedBox(height: 20.sp),
        _customizedText(FormatJalaliTo.getTodayFullDateTime(null)),
      ],
    );
  }

  Widget _todayStatusTitle() {
    return _customizedText(
      todayStatus.title,
      color: _getTitleColor(),
      sizeMultiplier: 1.5,
    );
  }

  Widget _inOutTime() {
    return Column(
      children: [
        todayStatus.inTime != null
            ? _customizedText("ساعت کاری", sizeMultiplier: 0.9)
            : Container(),
        SizedBox(height: 10.sp),
        todayStatus.inTime != null
            ? Text.rich(
                textDirection: TextDirection.rtl,
                TextSpan(
                  style: TextStyle(
                    fontSize: 17.sp,
                  ),
                  children: [
                    TextSpan(
                      text: todayStatus.inTime?.toStringFormat ?? "",
                      style: TextStyle(color: ColorPallet.orange),
                    ),
                    const TextSpan(text: "  تا  "),
                    TextSpan(
                      text: todayStatus.outTime?.toStringFormat ?? "",
                      style: TextStyle(color: ColorPallet.orange),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _updateButton() {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<WorkdaysCubit>(context).deleteWorkDay(todayStatus.id);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(ColorPallet.yaleBlue),
      ),
      child: Text(
        "تغییر وضعیت امروز",
        style: TextStyle(
          color: ColorPallet.smoke,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _shortDescription() {
    return Column(
      children: [
        todayStatus.shortDescription != null ? _customizedText("توضیحات") : Container(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.sp),
          child: _customizedText(todayStatus.shortDescription, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _customizedText(String? txt, {Color? color, double sizeMultiplier = 1}) {
    return Text(
      txt ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: (18.sp) * sizeMultiplier,
        color: color,
      ),
    );
  }

  _getTitleColor() {
    if (todayStatus.isDayOff) {
      return Colors.red;
    }
    if (todayStatus.isPublicHoliday) {
      return ColorPallet.orange;
    }
    if (todayStatus.isWorkDay) {
      return ColorPallet.green.withGreen(220);
    }
  }
}
