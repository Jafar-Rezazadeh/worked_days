import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/entities/color_schema.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';

Widget selectStatus(
    {required List<WorkDayModel> listOfStatus,
    required Function(WorkDayModel value) onChange,
    required double fontSize}) {
  return SizedBox(
    height: 50.sp,
    child: CustomRadioButton(
      height: 50,
      autoWidth: true,
      buttonLables: const [
        "کار کردم",
        "تعطیل رسمی",
        "تعطیل",
      ],
      buttonValues: listOfStatus,
      radioButtonValue: (value) => onChange(value),
      selectedBorderColor: ColorPallet.orange,
      unSelectedBorderColor: ColorPallet.yaleBlue,
      unSelectedColor: ColorPallet.smoke,
      selectedColor: ColorPallet.yaleBlue,
      defaultSelected: listOfStatus.first,
      enableShape: true,
      shapeRadius: 5,
      radius: 5,
      elevation: 0,
      buttonTextStyle: ButtonTextStyle(
        textStyle: TextStyle(
          fontSize: fontSize / 1.1,
        ),
      ),
    ),
  );
}
