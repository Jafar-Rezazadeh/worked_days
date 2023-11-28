import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/ui/extentions/shamsi_formater.dart';
import 'package:worked_days/ui/theme/color_schema.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';

class ShowSavedStatus extends StatelessWidget {
  final BuildContext context;
  final WorkDayModel todayStatus;
  final Function deleteTodayStatus;

  const ShowSavedStatus({
    super.key,
    required this.todayStatus,
    required this.context,
    required this.deleteTodayStatus,
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
                      text: "${todayStatus.inTime}",
                      style: TextStyle(color: ColorPallet.orange),
                    ),
                    const TextSpan(text: "  تا  "),
                    TextSpan(
                      text: "${todayStatus.outTime}",
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
        deleteTodayStatus(todayStatus.id);
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
    if (todayStatus.dayOff) {
      return Colors.red;
    }
    if (todayStatus.publicHoliday) {
      return ColorPallet.orange;
    }
    if (todayStatus.workDay) {
      return ColorPallet.green.withGreen(220);
    }
  }
}
