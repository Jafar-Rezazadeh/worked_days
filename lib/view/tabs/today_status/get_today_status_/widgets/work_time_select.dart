import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:worked_days/extentions/my_extentions.dart';
import 'package:worked_days/model/color_schema.dart';
import 'package:worked_days/model/worked_day_model.dart';

double workTimeSelectFontSize = 16.sp;
Widget workTimeSelect({
  required int radioGroupValue,
  required Function(int? value) onInTimechanged,
  required Function(int? value) onOutTimechanged,
  required Function(TimeOfDay? value) onInTimeChoosed,
  required Function(TimeOfDay? value) onOutTimeChoosed,
  required TimeOfDay? inTime,
  required TimeOfDay? outTime,
  required BuildContext context,
  required bool error,
  required WorkDayModel status,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    width: 300.sp,
    decoration: BoxDecoration(
      color: ColorPallet.smoke,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          blurRadius: 10,
          color: Colors.grey,
          spreadRadius: 2,
        )
      ],
    ),
    child: Column(
      children: [
        RadioListTile(
          fillColor: MaterialStatePropertyAll(ColorPallet.yaleBlue),
          value: 0,
          groupValue: radioGroupValue,
          onChanged: onInTimechanged,
          secondary: Row(
            textDirection: TextDirection.rtl,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: _regularText(
                  const TimeOfDay(hour: 8, minute: 00).format(context).toPersionPeriod,
                  ColorPallet.orange,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _regularText("الی", null),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: _regularText(
                  const TimeOfDay(hour: 18, minute: 00).format(context).toPersionPeriod,
                  ColorPallet.orange,
                ),
              ),
            ],
          ),
        ),
        RadioListTile(
          fillColor: MaterialStatePropertyAll(ColorPallet.yaleBlue),
          value: 1,
          groupValue: radioGroupValue,
          onChanged: onOutTimechanged,
          secondary: Row(
            textDirection: TextDirection.rtl,
            mainAxisSize: MainAxisSize.min,
            children: [
              _selectInTime(context, radioGroupValue, onInTimeChoosed, inTime),
              const SizedBox(width: 5),
              _regularText("الی", null),
              const SizedBox(width: 5),
              _selectOutTime(context, radioGroupValue, onOutTimeChoosed, outTime),
            ],
          ),
        ),
        error && radioGroupValue == 1
            ? Container(child: _regularText("لطفا زمان ورود و خروج را انتخاب کنید", Colors.red))
                .animate(target: error && radioGroupValue == 1 ? 1 : 0)
                .fade(begin: 0, end: 1)
            : Container()
      ],
    ),
  ).animate(target: status.id == 0 ? 1 : 0).scaleY(
        begin: 0,
        end: 1,
        alignment: Alignment.topCenter,
        duration: 400.milliseconds,
        delay: 0.microseconds,
        curve: Curves.easeInOutExpo,
      );
}

_regularText(String txt, Color? color) {
  return Text(
    txt,
    style: TextStyle(
      fontSize: workTimeSelectFontSize,
      color: color,
    ),
  );
}

_selectInTime(BuildContext context, int radioGroupValue, onIntimeChoosed, TimeOfDay? inTime) {
  return TextButton(
    style: _textButtonStyle(),
    onPressed: radioGroupValue == 1
        ? () async {
            await showPersianTimePicker(
              context: context,
              initialTime: const TimeOfDay(hour: 8, minute: 00),
            ).then(onIntimeChoosed);
          }
        : null,
    child: inTime != null ? Text(inTime.format(context).toPersionPeriod) : const Text("زمان ورود"),
  );
}

_selectOutTime(BuildContext context, int radioGroupValue, onOutTimeChoosed, TimeOfDay? outTime) {
  return TextButton(
    style: _textButtonStyle(),
    onPressed: radioGroupValue == 1
        ? () async {
            await showPersianTimePicker(
                    context: context, initialTime: const TimeOfDay(hour: 18, minute: 00))
                .then(onOutTimeChoosed);
          }
        : null,
    child:
        outTime != null ? Text(outTime.format(context).toPersionPeriod) : const Text("زمان خروج"),
  );
}

_textButtonStyle() {
  return ButtonStyle(
    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 9)),
    textStyle: MaterialStatePropertyAll(TextStyle(
      fontFamily: "Vazir",
      fontSize: workTimeSelectFontSize,
    )),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        } else {
          return ColorPallet.yaleBlue;
        }
      },
    ),
    shape: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      } else {
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(width: 1, color: ColorPallet.deepYellow),
        );
      }
    }),
  );
}
