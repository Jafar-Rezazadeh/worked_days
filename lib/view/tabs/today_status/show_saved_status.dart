import 'package:flutter/material.dart';
import 'package:worked_days/controller/shamsi_formater.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/worked_day_model.dart';

class ShowSavedStatus extends StatelessWidget {
  final BuildContext context;
  final WorkDayModel todayStatus;
  final Function deleteTodayStatus;
  final Size screenSize;
  const ShowSavedStatus({
    super.key,
    required this.todayStatus,
    required this.context,
    required this.deleteTodayStatus,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: screenSize.height / 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _customizedText("وضعیت امروز ", color: ColorPallet.yaleBlue, sizeMultiplier: 1.3),
          const SizedBox(height: 10),
          _customizedText(ShamsiFormatter.getTodayFullDateTime(null)),
          const SizedBox(height: 10),
          _customizedText(
            todayStatus.title,
            color: _getTitleColor(),
            sizeMultiplier: 1.1,
          ),
          const SizedBox(height: 5),
          todayStatus.inTime != null
              ? _customizedText("ساعت کاری", sizeMultiplier: 0.9)
              : Container(),
          const SizedBox(height: 5),
          todayStatus.inTime != null ? _inAndOutTime() : Container(),
          const SizedBox(height: 10),
          todayStatus.shortDescription != null ? _customizedText("توضیحات") : Container(),
          _customizedText(todayStatus.shortDescription, color: Colors.black54),
          const SizedBox(height: 20),
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
          fontSize: screenSize.width / 25,
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
        fontSize: (screenSize.width / 25) * sizeMultiplier,
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
          fontSize: screenSize.width / 25,
        ),
      ),
    );
  }
}
