import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/services/shamsi_formater_service.dart';
import 'package:worked_days/bloc/entities/color_schema.dart';
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
      padding: EdgeInsets.only(top: 50.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _customizedText("وضعیت امروز ", color: ColorPallet.yaleBlue, sizeMultiplier: 1.8),
          SizedBox(height: 20.sp),
          _customizedText(ShamsiFormatterService.getTodayFullDateTime(null)),
          SizedBox(height: 10.sp),
          _customizedText(
            todayStatus.title,
            color: _getTitleColor(),
            sizeMultiplier: 1.5,
          ),
          SizedBox(height: 10.sp),
          todayStatus.inTime != null
              ? _customizedText("ساعت کاری", sizeMultiplier: 0.9)
              : Container(),
          SizedBox(height: 10.sp),
          todayStatus.inTime != null ? _inAndOutTime() : Container(),
          SizedBox(height: 10.sp),
          todayStatus.shortDescription != null ? _customizedText("توضیحات") : Container(),
          _customizedText(todayStatus.shortDescription, color: Colors.black54),
          SizedBox(height: 20.sp),
          _updateButton(),
        ],
      ),
    );
  }

  _inAndOutTime() {
    return Text.rich(
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
    );
  }

  _customizedText(String? txt, {Color? color, double sizeMultiplier = 1}) {
    return Text(
      txt ?? "",
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
}
