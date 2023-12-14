import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color_schema.dart';
import '../../domain/entities/work_days.dart';
import '../shared_functions/list_of_status_samples.dart';

class SelectTodayStatus extends StatefulWidget {
  final Function(WorkDay) onChange;
  const SelectTodayStatus({super.key, required this.onChange});

  @override
  State<SelectTodayStatus> createState() => _SelectTodayStatusState();
}

class _SelectTodayStatusState extends State<SelectTodayStatus> {
  final List<WorkDay> listOfStatus = getListOfStatus();
  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      buttonTextStyle: ButtonTextStyle(textStyle: TextStyle(fontSize: 12.sp)),
      buttonLables: const ["روز کاری", "تعطیل رسمی", "تعطیل"],
      buttonValues: listOfStatus,
      radioButtonValue: (value) => widget.onChange(value),
      unSelectedColor: ColorPallet.smoke,
      selectedColor: ColorPallet.yaleBlue,
      shapeRadius: 10,
      unSelectedBorderColor: ColorPallet.yaleBlue,
      selectedBorderColor: ColorPallet.yaleBlue,
      defaultSelected: listOfStatus.first,
      enableShape: true,
    );
  }
}
