import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:worked_days/bloc/entities/worked_day_model.dart';
import 'package:worked_days/bloc/services/get_list_of_status.dart';
import 'package:worked_days/ui/theme/color_schema.dart';

class RadioButtonsOfTodayStatus extends StatefulWidget {
  final Function(WorkDayModel) onChange;
  const RadioButtonsOfTodayStatus({super.key, required this.onChange});

  @override
  State<RadioButtonsOfTodayStatus> createState() => _RadioButtonsOfTodayStatusState();
}

class _RadioButtonsOfTodayStatusState extends State<RadioButtonsOfTodayStatus> {
  List<WorkDayModel> listOfstatus = getListOfStatus();

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      buttonTextStyle: ButtonTextStyle(textStyle: TextStyle(fontSize: 12.sp)),
      buttonLables: const ["روز کاری", "تعطیل رسمی", "تعطیل"],
      buttonValues: listOfstatus,
      radioButtonValue: (value) => widget.onChange(value),
      unSelectedColor: ColorPallet.smoke,
      selectedColor: ColorPallet.yaleBlue,
      shapeRadius: 10,
      unSelectedBorderColor: ColorPallet.yaleBlue,
      selectedBorderColor: ColorPallet.yaleBlue,
      defaultSelected: listOfstatus.first,
      enableShape: true,
    );
  }
}
