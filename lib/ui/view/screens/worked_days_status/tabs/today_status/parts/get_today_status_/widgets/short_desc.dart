import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';

Widget addShortDescription({
  required WorkDayModel status,
  required Function(String value) onInputChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      width: 0.6.sw,
      child: TextField(
        onChanged: onInputChanged,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: "توضیح کوتاه",
          hintStyle: TextStyle(fontSize: 13.sp),
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.all(10),
        ),
        style: TextStyle(fontSize: 13.sp),
      ),
    ),
  ).animate(target: status.id == 0 || status.id == 2 ? 1 : 0).scaleY(
        begin: 0,
        end: 1,
        alignment: Alignment.topCenter,
        duration: 400.milliseconds,
        delay: 0.microseconds,
        curve: Curves.easeInOutExpo,
      );
}
